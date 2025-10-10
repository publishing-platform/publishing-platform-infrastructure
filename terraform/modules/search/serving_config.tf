locals {
  # TODO
  # boostControls   = yamldecode(file("${path.module}/files/controls/boosts.yml"))
  # synonymControls = yamldecode(file("${path.module}/files/controls/synonyms.yml"))
}

resource "restapi_object" "discovery_engine_serving_config" {
  # TODO
  # depends_on = [
  #   restapi_object.discovery_engine_boost_control,
  #   restapi_object.discovery_engine_synonym_control
  # ]

  path      = "/engines/${google_discovery_engine_search_engine.publishing_platform_engine.engine_id}/servingConfigs/default_search?updateMask=boost_control_ids,synonyms_control_ids"
  object_id = "default_search"

  # Since the default serving config is created automatically with the engine, we need to update
  # even on initial Terraform resource creation
  create_method = "PATCH"
  create_path   = "/engines/${google_discovery_engine_search_engine.publishing_platform_engine.engine_id}/servingConfigs/default_search?updateMask=boost_control_ids,synonyms_control_ids"
  update_method = "PATCH"
  update_path   = "/engines/${google_discovery_engine_search_engine.publishing_platform_engine.engine_id}/servingConfigs/default_search?updateMask=boost_control_ids,synonyms_control_ids"
  read_path     = "/engines/${google_discovery_engine_search_engine.publishing_platform_engine.engine_id}/servingConfigs/default_search"

  # TODO
  data = jsonencode({
    boostControlIds    = [] # keys(local.boostControls)
    synonymsControlIds = [] # keys(local.synonymControls)
  })
}