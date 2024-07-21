provider "google" {
  project = "ese-exam-sandbox-acosta-h"
  region  = "us-central1"
  credentials = "/Users/hendrickacosta/Downloads/ese-exam-sandbox-acosta-h-b111477628ec.json"
}


module "cloud_sql_instance" {
  source            = "./modules/cloud-sql"  # Update with the relative path to your module
  project_id        = var.project_id
  region            = var.region
  instance_name     = var.instance_name
  database_name     = var.database_name
  database_user     = var.database_user
  database_password = var.database_password
  publication_name  = var.publication_name
  credentials_file  = var.credentials_file
}

module "storage_bucket" {
  source      = "./modules/cloud-storage"  # Update with the relative path to your module
  project_id  = var.project_id
  region      = var.region
  bucket_name = var.bucket_name
}

module "compute_engine"{
  project_id  = var.project_id
  region      = var.region
  bucket_name = var.bucket_name
}

module "bigquery"{
  project_id  = var.project_id
  region      = var.region
  bucket_name = var.bucket_name
}

# module "vertex_ai" {
#   source               = "./modules/vertexai"
#   project_id           = var.project_id
#   model_name           = var.model_name
#   model_display_name   = var.model_display_name
#   model_artifact_uri   = var.model_artifact_uri
#   endpoint_name        = var.endpoint_name
#   machine_type         = var.machine_type
# }

# module "dataflow_python_job" {
#   source                = "./modules/dataflow"  # Update with the relative path to your module
#   project_id            = var.project_id
#   region                = var.region
#   bucket_name           = var.bucket_name
#   job_name              = var.job_name
#   template_path         = var.template_path
#   parameters_path       = var.parameters_path
#   local_template_file   = var.local_template_file
#   local_parameters_file = var.local_parameters_file
#   service_account_email = var.service_account_email
# }
