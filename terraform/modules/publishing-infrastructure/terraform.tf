# This module manages AWS resources which are specific to Publishing Platform Publishing.

terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["publishing-infrastructure", "eks", "aws"]
    }
  }

  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.65.0"
    }
  }
}