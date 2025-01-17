variable "organization" {
  type        = string
  default     = "publishing-platform"
  description = "The name of the Terraform Cloud organization"
}

variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "github_app_id" {
  type        = string
  description = "The id of the GitHub App used for authentication."
}

variable "github_app_installation_id" {
  type        = string
  description = "The id of the installation of the GitHub App used for authentication."
}

variable "github_app_pem_file" {
  type        = string
  description = "The private key to sign access token requests."
  sensitive   = true
}

variable "puller_arns" {
  type        = list(string)
  description = "List of IAM principals who should be authorised to pull from this registry."
}

variable "force_destroy" {
  type        = bool
  description = "Setting for force_destroy on resources such as ECR repostories. For use in non-production environments to allow for automated tear-down."
  default     = false
}