terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["rds-security", "eks", "aws"]
    }
  }

  required_version = "~> 1.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.74.0"
    }
  }
}