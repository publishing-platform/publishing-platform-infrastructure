terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["tfc", "aws", "configuration"]
    }
  }

  required_version = "~> 1.14"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.74.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.28"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1"
    }
  }
}