provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_vertex_ai_endpoint" "endpoint" {
  display_name = var.endpoint_name
  project      = var.project_id
  region       = var.region
  location     = var.region
  name         = var.endpoint_name
}

# resource "google_vertex_ai_model_deployment" "model_deployment" {
#   model_id     = var.model_id
#   endpoint_id  = google_vertex_ai_endpoint.endpoint.id
#   machine_type = var.machine_type
#   min_replica_count = 1
#   max_replica_count = 5

  
# }