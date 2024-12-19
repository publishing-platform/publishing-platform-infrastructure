locals {
  services_ns            = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_services_namespace
  monitoring_ns          = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.monitoring_namespace
  external_dns_zone_name = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.external_dns_zone_name
  dex_host               = "dex.${local.external_dns_zone_name}"
}