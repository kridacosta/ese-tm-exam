variable "project_id" {
  description = "The ID of the project in which to create the Cloud SQL instance."
  type        = string
}

variable "region" {
  description = "The region in which to create the Cloud SQL instance."
  type        = string
  default     = "us-central1"
}

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