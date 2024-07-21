# variables.tf
variable "project_id" {
  description = "The ID of the Google Cloud project in which the dataset will be created."
  type        = string
}

variable "dataset_id" {
  description = "The ID of the BigQuery dataset to create."
  type        = string
  default     = "cx"
}

variable "location" {
  description = "The location where the BigQuery dataset will be created."
  type        = string
  default     = "US"
}

variable "description" {
  description = "A description for the BigQuery dataset."
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels for the BigQuery dataset."
  type        = map(string)
  default     = {}
}

variable "reader_email" {
  description = "Email of the user who will have read access to the dataset."
  type        = string
  default     = ""
}
