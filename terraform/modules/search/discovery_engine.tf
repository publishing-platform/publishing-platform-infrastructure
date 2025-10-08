# TODO: These IDs/paths are semi-hardcoded here as there aren't first party resources/data sources
# available for them yet.
locals {
  discovery_engine_default_location_name   = "projects/${var.gcp_project_id}/locations/global"
  discovery_engine_default_collection_name = "${local.discovery_engine_default_location_name}/collections/default_collection"
}