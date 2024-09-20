provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Product     = "Publishing Platform"
      System      = "Terraform Cloud"
      Environment = var.publishing_platform_environment
      Repository  = "publishing-platform-infrastructure"
      Workspace   = terraform.workspace
    }
  }
}

provider "tfe" {
  hostname     = var.tfc_hostname
  organization = var.organization
}