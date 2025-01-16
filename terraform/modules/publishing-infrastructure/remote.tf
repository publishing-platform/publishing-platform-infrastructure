data "tfe_outputs" "cluster_infrastructure" {
  organization = "publishing-platform"
  workspace    = "cluster-infrastructure-${var.publishing_platform_environment}"
}