variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE to use with AWS"
}

variable "organisation" {
  type        = string
  default     = "publishing-platform"
  description = "The name of the Terraform Cloud organisation"
}