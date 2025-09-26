locals {
  display_name = title(var.publishing_platform_environment)
}

resource "google_project" "environment_project" {
  name       = "Search API ${local.display_name}"
  project_id = "publishing-platform-search-api-${var.publishing_platform_environment}"

  folder_id       = var.google_cloud_folder
  billing_account = var.google_cloud_billing_account

  labels = {
    "programme"                       = var.organization
    "publishing_platform_environment" = var.publishing_platform_environment
  }
}