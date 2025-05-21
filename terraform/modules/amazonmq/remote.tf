data "tfe_outputs" "vpc" {
  organization = "publishing-platform"
  workspace    = "vpc-${var.publishing_platform_environment}"
}

data "tfe_outputs" "shared" {
  organization = "publishing-platform"
  workspace    = "shared-${var.publishing_platform_environment}"
}