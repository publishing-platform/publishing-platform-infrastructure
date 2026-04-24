terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["tfc", "configuration"]
    }
  }

  required_version = "~> 1.14"
}