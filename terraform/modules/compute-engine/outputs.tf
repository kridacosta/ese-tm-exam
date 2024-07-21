# outputs.tf
output "instance_name" {
  description = "The name of the compute instance."
  value       = google_compute_instance.cdc_capture.name
}

output "instance_self_link" {
  description = "The self link of the compute instance."
  value       = google_compute_instance.cdc_capture.self_link
}