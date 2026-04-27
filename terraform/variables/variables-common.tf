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