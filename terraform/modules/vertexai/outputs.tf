
output "model_id" {
  description = "The ID of the Vertex AI model."
  value       = google_vertex_ai_model.model.id
}

output "endpoint_id" {
  description = "The ID of the Vertex AI endpoint."
  value       = google_vertex_ai_endpoint.endpoint.id
}