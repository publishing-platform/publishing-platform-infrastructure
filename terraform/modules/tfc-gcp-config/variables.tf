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