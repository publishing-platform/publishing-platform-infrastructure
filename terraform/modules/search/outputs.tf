output "discovery_engine_default_collection_name" {
  description = "The Discovery Engine default collection name."
  value       = local.discovery_engine_default_collection_name
}

output "discovery_engine_default_location_name" {
  description = "The Discovery Engine default location name."
  value       = local.discovery_engine_default_location_name
}

output "google_cloud_credentials" {
  description = "The Google service account key private key in JSON format, base64 encoded."
  value       = google_service_account_key.api.private_key
  sensitive   = true
}
