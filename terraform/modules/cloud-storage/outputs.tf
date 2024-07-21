output "bucket_url" {
  description = "The URL of the created Cloud Storage bucket."
  value       = "gs://${google_storage_bucket.bucket.name}"
}

output "bucket_self_link" {
  description = "The self link of the Cloud Storage bucket."
  value       = google_storage_bucket.bucket.self_link
}
