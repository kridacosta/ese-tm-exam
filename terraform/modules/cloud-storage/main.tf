resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.region


  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true

  labels = {
    environment = "dev"
  }
}
