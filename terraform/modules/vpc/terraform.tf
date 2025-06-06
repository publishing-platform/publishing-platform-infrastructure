# Manages AWS resources relating to the Publishing Platform VPC.

terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["vpc", "eks", "aws"]
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