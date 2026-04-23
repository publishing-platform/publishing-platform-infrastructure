terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["tfc", "gcp", "configuration"]
    }
  }

  required_version = "~> 1.14"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.55.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}