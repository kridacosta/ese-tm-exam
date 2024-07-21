output "dataflow_job_id" {
  description = "The ID of the Dataflow job."
  value       = google_dataflow_flex_template_job.default.id
}

output "dataflow_job_name" {
  description = "The name of the Dataflow job."
  value       = google_dataflow_flex_template_job.default.name
}
