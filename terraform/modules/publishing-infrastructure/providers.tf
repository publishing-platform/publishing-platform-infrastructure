locals {
  default_tags = {
    Product     = "Publishing Platform"
    System      = "Publishing infrastructure"
    Environment = var.publishing_platform_environment
    Repository  = "publishing-platform-infrastructure"
    Workspace   = terraform.workspace
  }
}

provider "aws" {
  region = "eu-west-2"
  default_tags { tags = local.default_tags }
}

provider "aws" {
  region = "eu-west-1"
  alias  = "replica"
  default_tags { tags = local.default_tags }
}