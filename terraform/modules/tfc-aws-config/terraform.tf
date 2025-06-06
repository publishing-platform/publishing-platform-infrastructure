terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["tfc", "aws", "configuration"]
    }
  }

  required_version = "~> 1.10"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.55.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}