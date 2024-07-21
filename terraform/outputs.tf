output "instance_connection_name" {
  value = module.cloud_sql_instance.instance_connection_name
}

output "instance_self_link" {
  value = module.cloud_sql_instance.instance_self_link
}

output "bucket_url" {
  value = module.storage_bucket.bucket_url
}

output "bucket_self_link" {
  value = module.storage_bucket.bucket_self_link
}

# output "dataflow_job_id" {
#   value = module.dataflow_python_job.dataflow_job_id
# }

# output "dataflow_job_name" {
#   value = module.dataflow_python_job.dataflow_job_name
# }