locals {
  github_oidc_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
}

data "aws_iam_openid_connect_provider" "github_oidc" {
  arn = local.github_oidc_arn
}