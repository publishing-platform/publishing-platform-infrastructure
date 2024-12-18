data "aws_iam_roles" "admin" {
  name_regex  = "^AWSReservedSSO_AdministratorAccess_.*"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_iam_roles" "tfc" {
  name_regex = "^terraform-cloud$"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "tfe_outputs" "vpc" {
  organization = "publishing-platform"
  workspace    = "vpc-${var.publishing_platform_environment}"
}