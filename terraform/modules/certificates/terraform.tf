terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["certificates", "aws"]
    }
  }

  required_version = "~> 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.55.0"
    }
  }
}