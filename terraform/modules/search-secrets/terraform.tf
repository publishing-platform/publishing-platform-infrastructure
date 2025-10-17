terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["search-secrets", "eks", "aws"]
    }
  }

  required_version = "~> 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.55.0"
    }
  }
}