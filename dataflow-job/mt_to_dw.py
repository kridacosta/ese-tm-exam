import random
import string
import time
import json
import apache_beam as beam
import yaml
from apache_beam.options.pipeline_options import PipelineOptions
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail, Email, To, Content
import os

def get_random_string(n):
    return ''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(n))

def load_params_file(params_file):
    with open(params_file, 'r') as stream:
        return yaml.safe_load(stream)

def flatten_records_if_batched(item):
    if type(item) == dict:
        return [item]
    elif type(item) == list:
        return item
    else:
        raise ValueError("Unknown type received: {}".format(type(item)))

def get_random_value():
    return random.random()

def add_fraud_score(record):
    record['fraud_score'] = get_random_value()
    return record

def send_email(record):
    sg = SendGridAPIClient(api_key="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")
    from_email = Email("gold-standard@thinkingmachin.es")  # Change to your verified sender
    to_email = To("hendrickacosta1594@gmail.com")  # Change to your recipient
    subject = "Fraud Alert"
    content = Content("text/plain", f"Fraud score: {record['fraud_score']}\nRecord: {record}")
    mail = Mail(from_email, to_email, subject, content)
    
    response = sg.send(mail)
    print(response.status_code)
    print(response.body)
    print(response.headers)

class SendEmailIfFraud(beam.DoFn):
    def process(self, record):
        if record['fraud_score'] > 0.3:
            send_email(record)
        yield record

def _create_pipeline_options(params):
    pipeline_options = PipelineOptions.from_dictionary({
        'project': params['project'],
        'runner': 'DataflowRunner',
        'streaming': True,
        'temp_location': 'gs://{}/dataflow-staging/temp'.format(params['bucket']),
        'staging_location': 'gs://{}/dataflow-staging/staging'.format(params['bucket']),
        'job_name': 'mt-to-dw-{}'.format(get_random_string(6)),
        'num_workers': params['num_workers'],
        'region': params['region'],
        'autoscaling_algorithm': 'NONE',
        'worker_machine_type': params['machine_type'],
        'disk_size_gb': params['disk_size'],
        'save_main_session': True,
        'network': 'projects/{}/global/networks/{}'.format(params['project'], params['network']),
        'subnetwork': 'regions/{}/subnetworks/{}'.format(params['region'], params['subnetwork']),
        'setup_file': "./setup.py",
    })
    return pipeline_options

def create_dataflow_pipeline(params):
    pipeline_options = _create_pipeline_options(params)
    p = beam.Pipeline(options=pipeline_options)
    (p
     | 'ReadFromPubSub' >> beam.io.ReadFromPubSub(topic='projects/{}/topics/{}'.format(params['project'], params['pubsub_topic']))
     | 'ParseMessages' >> beam.Map(lambda x: json.loads(x.decode('utf-8')))
     | 'FlattenIfBatch' >> beam.FlatMap(flatten_records_if_batched)
     | 'AddFraudScore' >> beam.Map(add_fraud_score)
     | 'SendEmailIfFraud' >> beam.ParDo(SendEmailIfFraud())
     | 'Reshuffle' >> beam.Reshuffle()
     | 'AddTimestamp' >> beam.Map(lambda x: dict(x, **{'processing_time': int(time.time())}))
     | 'WriteToBigQuery' >> beam.io.WriteToBigQuery(
         project=params['output']['project'],
         dataset=params['output']['dataset'],
         table=params['output']['table'],
         schema=params['output']['schema'],
         write_disposition=params['output']['write_disposition'],
         create_disposition=params['output']['create_disposition']
     ))
    return p

def main():
    params = load_params_file("params.yaml")
    pipeline = create_dataflow_pipeline(params)
    pipeline.run()

if __name__ == "__main__":
    main()
