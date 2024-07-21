provider "google-beta" {
  project = "ese-exam-sandbox-acosta-h"
  region  = "us-central1"
  credentials = "/Users/hendrickacosta/Downloads/ese-exam-sandbox-acosta-h-b111477628ec.json"
}

resource "google_storage_bucket" "dataflow_bucket" {
  name     = var.bucket_name
  location = var.region
}

resource "google_storage_bucket_object" "dataflow_template" {
  name   = var.template_path
  bucket = google_storage_bucket.dataflow_bucket.name
  source = var.local_template_file
}

resource "google_storage_bucket_object" "dataflow_parameters" {
  name   = var.parameters_path
  bucket = google_storage_bucket.dataflow_bucket.name
  source = var.local_parameters_file
}

resource "google_dataflow_flex_template_job" "default" {
  provider = google-beta 
  

  name             = var.job_name
  container_spec_gcs_path = "gs://${google_storage_bucket.dataflow_bucket.name}/${google_storage_bucket_object.dataflow_template.name}"
  ##parameters        = jsondecode(file(var.local_parameters_file))
  service_account_email = var.service_account_email
  temp_location         = "gs://${google_storage_bucket.dataflow_bucket.name}/temp"
  
}