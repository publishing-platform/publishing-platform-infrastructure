# Manages AWS resources relating to the Publishing Platform VPC.

terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["ses", "eks", "aws"]
    }
  }

  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
  }
}