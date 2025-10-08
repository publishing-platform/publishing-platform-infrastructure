variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID of the project to create infrastructure in, e.g. search-api-integration-1234"
}

variable "force_destroy" {
  type        = bool
  description = "Forces destruction of resources. For use in non-production environments to allow for automated tear-down."
  default     = false
}