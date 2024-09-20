variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE to use with AWS"
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
