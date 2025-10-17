provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Product     = "Publishing Platform"
      System      = "Search"
      Environment = var.publishing_platform_environment
      Repository  = "publishing-platform-infrastructure"
      Workspace   = terraform.workspace
    }
  }
}

provider "google" {
  project = data.tfe_outputs.tfc_gcp_config.nonsensitive_values.gcp_project_id
  region  = "europe-west2"
  scopes = [
    # Default scopes requested by Terraform Google provider
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
    # Needed for `google_bigquery_table` to use Google Drive as source
    "https://www.googleapis.com/auth/drive.readonly",
  ]
}

# Used to extract access token from the provider so we can call the REST API
data "google_client_config" "default" {}

# Using REST API provider as a "temporary" workaround, as there are no native Terraform resources
# for Discovery Engine in the Google provider yet
provider "restapi" {
  uri = "https://discoveryengine.googleapis.com/${var.discovery_engine_api_version}/${local.discovery_engine_default_collection_name}"

  # Writes in GCP APIs return an "operation" reference rather than the object being written
  write_returns_object = false

  # Discovery Engine API uses POST for create, PATCH for update
  create_method = "POST"
  update_method = "PATCH"

  headers = {
    # Piggyback on the the Terraform provider's generated temporary credentials to authenticate
    # to the API with
    "Authorization"       = "Bearer ${data.google_client_config.default.access_token}"
    "X-Goog-User-Project" = data.tfe_outputs.tfc_gcp_config.nonsensitive_values.gcp_project_id
  }
}

provider "random" {}