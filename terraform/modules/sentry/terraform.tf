terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      name = "sentry-production"
    }
  }

  required_version = "~> 1.14"

  required_providers {
    sentry = {
      source  = "jianyuan/sentry"
      version = "0.14.11"
    }
  }
}