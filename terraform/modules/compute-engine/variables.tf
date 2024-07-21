variable "project_id" {
  description = "The ID of the project in which the resources will be created."
  type        = string
}

variable "region" {
  description = "The region in which the instance will be created."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which the instance will be created."
  type        = string
  default     = "us-central1-c"
}