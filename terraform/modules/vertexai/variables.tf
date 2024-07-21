variable "project_id" {
  description = "The GCP project ID where resources will be created."
  type        = string
}

variable "region" {
  description = "The region where Vertex AI resources will be created."
  type        = string
  default     = "us-central1"
}

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

variable "model_id" {
  description = "The model id"
  type        = string
}