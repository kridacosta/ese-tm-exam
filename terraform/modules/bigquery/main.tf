# main.tf
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id
  location   = var.location

  labels = var.labels

}


