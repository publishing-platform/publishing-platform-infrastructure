# provider "random" {}

provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Product     = "Publishing Platform"
      System      = "Amazon MQ"
      Environment = var.publishing_platform_environment
      Repository  = "publishing-platform-infrastructure"
      Workspace   = terraform.workspace
    }
  }
}