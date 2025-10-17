variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "force_destroy" {
  type        = bool
  description = "Forces destruction of resources. For use in non-production environments to allow for automated tear-down."
  default     = false
}