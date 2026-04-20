terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      name = "tfc-bootstrap"
    }
  }

  required_version = "~> 1.10"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.66.0"
    }
  }
}