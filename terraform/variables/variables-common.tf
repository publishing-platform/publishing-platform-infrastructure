// variables-common.tf
//
// This file contains variable blocks for all common variables.
// If a Terraform root requires any common variables, this file should be symlinked into the root.
// Variables specific to a particular root should be declared in the variables.tf file for that root.

// General

variable "publishing_platform_environment" {
  type        = string
  description = "Name of the environment."

  validation {
    condition = (
      contains(["production", "staging", "integration", "test"], var.publishing_platform_environment)
    )

    error_message = "Environment name must be one of production, staging, integration, or test."
  }
}

variable "publishing_service_domain" {
  type        = string
  description = "The publishing domain for this environment."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Whether to force destroy resources when removing Terraform resources."
}

// Networking

variable "vpc_cidr" {
  type        = string
  description = "IPv4 CIDR for VPC"

  validation {
    condition = cidrhost(var.vpc_cidr, 0) != null

    error_message = "vpc_cidr must be set to a valid CIDR."
  }
}

// Kubernetes

variable "cluster_name" {
  type        = string
  default     = "publishing-platform"
  description = "Name of the EKS cluster for this environment."

  validation {
    condition = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 100

    error_message = "Length of cluster_name must be between 1 and 100 characters."
  }
}