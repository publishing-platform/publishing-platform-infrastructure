# Manages AWS resources relating to the Publishing Platform VPC.

terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["search", "gcp"]
    }
  }

  required_version = "~> 1.14"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }

    restapi = {
      source  = "Mastercard/restapi"
      version = "~> 2.0.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.74.0"
    }
  }
}