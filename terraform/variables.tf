variable "project_id" {
  description = "The ID of the project in which to create the Cloud SQL instance."
  type        = string
}

variable "region" {
  description = "The region in which to create the Cloud SQL instance."
  type        = string
  default     = "us-central1"
}

### SQL Database
variable "instance_name" {
  description = "The name of the Cloud SQL instance."
  type        = string
}

variable "database_name" {
  description = "The name of the database to be created in the Cloud SQL instance."
  type        = string
}

variable "database_user" {
  description = "The name of the database user."
  type        = string
}

variable "database_password" {
  description = "The password for the database user."
  type        = string
}


variable "publication_name" {
  description = "The name of the publication for logical replication."
  type        = string
  default     = "mypub"
}

variable "credentials_file" {
  description = "The path to the JSON file containing your Google Cloud service account key."
  type        = string
}

## Cloud storage

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket."
  type        = string
  default     = "amt-storage-ese-hendrick"
}

## dataflow

variable "job_name" {
  description = "The name of the Dataflow job."
  type        = string
}

variable "template_path" {
  description = "The path to the Dataflow job template in the Cloud Storage bucket."
  type        = string
}

variable "parameters_path" {
  description = "The path to the YAML file containing the parameters in the Cloud Storage bucket."
  type        = string
}

variable "local_template_file" {
  description = "The local path to the Dataflow job template file."
  type        = string
}

variable "local_parameters_file" {
  description = "The local path to the YAML file containing the parameters."
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account to run the Dataflow job."
  type        = string
}

## vertexai

variable "model_name" {
  description = "The name of the Vertex AI model."
  type        = string
}

variable "model_display_name" {
  description = "The display name for the Vertex AI model."
  type        = string
}

variable "model_artifact_uri" {
  description = "GCS URI to the model artifact."
  type        = string
}

variable "endpoint_name" {
  description = "The name of the Vertex AI endpoint."
  type        = string
}

variable "machine_type" {
  description = "The machine type to use for the model deployment."
  type        = string
  default     = "n1-standard-4"
}