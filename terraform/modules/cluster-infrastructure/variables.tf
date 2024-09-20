variable "cluster_name" {
  type        = string
  description = "Name for the EKS cluster."
  default     = "publishing-platform"
}

variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}