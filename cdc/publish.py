import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import select
from google.cloud import pubsub_v1


def publish_to_pubsub(message):
    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path('ese-exam-sandbox-acosta-h', 'cdc-amt')
    publisher.publish(topic_path, message.encode('utf-8'))
    
def dblistener():
    connection = psycopg2.connect(
            host="10.87.0.3",
            database="amt",
            user="dbuser",
            password="amtdbuser")

    connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = connection.cursor()
    cur.execute("LISTEN insert_event;")
    while True:
        select.select([connection], [], [])
        connection.poll()
        while connection.notifies:
            notify = connection.notifies.pop()
            publish_to_pubsub(notify.payload)
            
def main():
    for change in get_changes():
        publish_to_pubsub(change)
    return 'Change data capture started', 200

main()