variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}