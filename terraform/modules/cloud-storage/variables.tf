variable "project_id" {
  description = "The ID of the project in which to create the Cloud Storage bucket."
  type        = string
}

variable "region" {
  description = "The region in which to create the Cloud Storage bucket."
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket."
  type        = string
  default     = "amt-storage-ese-hendrick"
}