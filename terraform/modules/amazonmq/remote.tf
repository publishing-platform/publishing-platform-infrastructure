data "tfe_outputs" "vpc" {
  organization = "publishing-platform"
  workspace    = "vpc-${var.publishing_platform_environment}"
}