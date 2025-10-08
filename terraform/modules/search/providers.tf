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
  project = var.gcp_project_id
  region  = "europe-west2"
  scopes = [
    # Default scopes requested by Terraform Google provider
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
    # Needed for `google_bigquery_table` to use Google Drive as source
    "https://www.googleapis.com/auth/drive.readonly",
  ]
}