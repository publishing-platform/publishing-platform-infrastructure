variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "discovery_engine_api_version" {
  type        = string
  description = "The version of the Discovery Engine API to use, e.g. v1alpha"
  # Defaulting to `v1alpha` as `v1beta` and `v1` APIs don't support all required features yet
  # (e.g. `completionConfig` management as of Jun 2025)
  default = "v1alpha"
}

variable "force_destroy" {
  type        = bool
  description = "Forces destruction of resources. For use in non-production environments to allow for automated tear-down."
  default     = false
}
