variable "project_id" {
  description = "The ID of the project in which to create the Dataflow job."
  type        = string
}

variable "region" {
  description = "The region in which to create the Dataflow job."
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket to store Dataflow job files."
  type        = string
}

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
