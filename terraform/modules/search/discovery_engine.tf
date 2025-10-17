# TODO: These IDs/paths are semi-hardcoded here as there aren't first party resources/data sources
# available for them yet.
locals {
  discovery_engine_default_location_name   = "projects/${data.tfe_outputs.tfc_gcp_config.nonsensitive_values.gcp_project_id}/locations/global"
  discovery_engine_default_collection_name = "${local.discovery_engine_default_location_name}/collections/default_collection"
}

resource "google_discovery_engine_data_store" "publishing_platform_data_Store" {
  data_store_id = "publishing_platform_content_store"
  display_name  = "publishing_platform_content_store"
  location      = "global"

  industry_vertical = "GENERIC"
  content_config    = "CONTENT_REQUIRED" # == "unstructured" datastore
  solution_types    = ["SOLUTION_TYPE_SEARCH"]

  lifecycle {
    ignore_changes = [
      # TODO: Annoyingly, this field is not updatable by us, but can change internally (and indeed
      # has changed in integration after some engine experiments). This means we need to ignore
      # changes to it to avoid unnecessary resource replacements.
      solution_types
    ]
  }
}

resource "google_discovery_engine_search_engine" "publishing_platform_engine" {
  engine_id    = "publishing_platform_global"
  display_name = "Publishing Platform Global Search"

  location      = google_discovery_engine_data_store.publishing_platform_data_Store.location
  collection_id = "default_collection"

  industry_vertical = "GENERIC"

  data_store_ids = [google_discovery_engine_data_store.publishing_platform_data_Store.data_store_id]

  search_engine_config {
    search_tier    = "SEARCH_TIER_STANDARD"
    search_add_ons = []
  }

  common_config {
    company_name = "Publishing Platform"
  }
}