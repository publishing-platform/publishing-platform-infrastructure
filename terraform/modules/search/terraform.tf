# Manages AWS resources relating to the Publishing Platform VPC.

terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["search", "gcp"]
    }
  }

  required_version = "~> 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }

    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }

    restapi = {
      source  = "Mastercard/restapi"
      version = "~> 2.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}