data "aws_iam_roles" "admin" {
  name_regex  = "AWSReservedSSO_AdministratorAccess_.*"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}