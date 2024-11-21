terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      name = ["github-production"]
    }
  }

  required_version = "~> 1.5"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}