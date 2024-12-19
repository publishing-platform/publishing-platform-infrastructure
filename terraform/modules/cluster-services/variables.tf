variable "apps_namespace" {
  type        = string
  description = "Name of the namespace to create for ArgoCD to deploy apps into by default."
  default     = "apps"
}

variable "cluster_name" {
  type        = string
  description = "Name for the EKS cluster."
  default     = "publishing-platform"
}

variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "helm_timeout_seconds" {
  type        = number
  description = "Timeout for helm install/upgrade operations."
  default     = "1200"
}

variable "desired_ha_replicas" {
  type        = number
  description = "Default number of desired replicas for high availability"
  default     = 3
}

variable "github_read_write_team" {
  type        = string
  description = "Name of the GitHub team that should have read-write access to Dex SSO-enabled applications"
  default     = "publishing-platform:publishing-platform-production-admin"
}

variable "github_read_only_team" {
  type        = string
  description = "Name of the GitHub team that should have read-only access to Dex SSO-enabled applications"
  default     = "publishing-platform:publishing-platform"
}