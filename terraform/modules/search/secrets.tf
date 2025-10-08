resource "aws_secretsmanager_secret" "discovery_engine_configuration" {
  name                    = "publishing-platform/search-api/google-cloud-discovery-engine-configuration"
  recovery_window_in_days = var.force_destroy ? 0 : 7
}

resource "aws_secretsmanager_secret_version" "discovery_engine_configuration" {
  secret_id = aws_secretsmanager_secret.discovery_engine_configuration.id
  secret_string = jsonencode({
    "GOOGLE_CLOUD_CREDENTIALS"                 = base64decode(google_service_account_key.api.private_key)
    "GOOGLE_CLOUD_PROJECT_ID"                  = var.gcp_project_id
    "DISCOVERY_ENGINE_DEFAULT_COLLECTION_NAME" = local.discovery_engine_default_collection_name
    "DISCOVERY_ENGINE_DEFAULT_LOCATION_NAME"   = local.discovery_engine_default_location_name
  })
}