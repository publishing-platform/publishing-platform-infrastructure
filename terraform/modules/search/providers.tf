provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Product     = "Publishing Platform"
      System      = "Search"
      Environment = var.publishing_platform_environment
      Repository  = "publishing-platform-infrastructure"
      Workspace   = terraform.workspace
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = "europe-west2"
}