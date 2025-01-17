data "tfe_outputs" "rds" {
  organization = "publishing-platform"
  workspace    = "rds-${var.publishing_platform_environment}"
}

data "tfe_outputs" "cluster_infrastructure" {
  organization = "publishing-platform"
  workspace    = "cluster-infrastructure-${var.publishing_platform_environment}"
}