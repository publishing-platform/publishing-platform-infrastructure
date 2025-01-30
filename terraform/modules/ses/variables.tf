variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "domain_name" {
  type        = string
  description = "The domain emails will be sent from."
  default     = "publishing-platform.co.uk"
}