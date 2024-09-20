provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Product     = "Publishing Platform"
      System      = "EKS cluster infrastructure"
      Environment = var.publishing_platform_environment
      Cluster     = var.cluster_name
      Repository  = "publishing-platform-infrastructure"
      Workspace   = terraform.workspace
    }
  }
}