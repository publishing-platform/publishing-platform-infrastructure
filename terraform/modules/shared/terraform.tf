terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["shared", "eks", "aws"]
    }
  }

  required_version = "~> 1.10"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}