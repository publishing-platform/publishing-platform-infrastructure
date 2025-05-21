terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["shared", "eks", "aws"]
    }
  }

  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}