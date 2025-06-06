terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["ecr", "eks", "aws"]
    }
  }

  required_version = "~> 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}