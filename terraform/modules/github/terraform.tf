terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      name = ["github-production"]
    }
  }

  required_version = "~> 1.5"

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