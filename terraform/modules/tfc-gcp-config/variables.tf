variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE to use with GCP"
}

variable "organization" {
  type        = string
  default     = "publishing-platform"
  description = "The name of the Terraform Cloud organization"
}

variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "google_cloud_folder" {
  type        = string
  description = "The ID of the Google Cloud folder to create projects under"
}

variable "google_cloud_billing_account" {
  type        = string
  description = "The ID of the Google Cloud billing account to associate projects with"
}

variable "google_cloud_apis" {
  type        = set(string)
  description = "The Google Cloud APIs to enable for the project"
  default = [
    # Required to be able to manage resources using Terraform
    "cloudresourcemanager.googleapis.com",
    # Required to set up service accounts and manage dynamic credentials
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
    # Required for Discovery Engine
    "discoveryengine.googleapis.com",
    # Required for event data pipeline
    "bigquery.googleapis.com",
    "bigquerystorage.googleapis.com",
    "storage.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudfunctions.googleapis.com",
    "run.googleapis.com",
    "cloudscheduler.googleapis.com",
    # Required for observability
    "logging.googleapis.com",
    "monitoring.googleapis.com",
  ]
}