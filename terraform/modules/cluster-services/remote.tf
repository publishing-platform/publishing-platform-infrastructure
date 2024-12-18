data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "tfe_outputs" "vpc" {
  organization = "publishing-platform"
  workspace    = "vpc-${var.publishing_platform_environment}"
}

data "tfe_outputs" "cluster_infrastructure" {
  organization = "publishing-platform"
  workspace    = "cluster-infrastructure-${var.publishing_platform_environment}"
}
