resource "restapi_object" "google_discovery_engine_datastore_schema" {
  path      = "/dataStores/${google_discovery_engine_data_store.publishing_platform_data_Store.data_store_id}/schemas"
  object_id = "default_schema"

  data = jsonencode({
    structSchema = {
      "$schema" = "https://json-schema.org/draft/2020-12/schema"
      type      = "object"
      properties = {
        # Unique content ID from the Publishing API (for debugging/retrieving single objects)
        content_id = {
          type        = "string"
          retrievable = true
        }
        # Unique identifier for search quality evaluation (identical to content_id)
        #
        # Note: This is only used to compare results for evaluation purposes, and is not a URL
        # despite the name. We decided against using the alternative 'uri' field name to avoid
        # confusion with our existing 'url' field and 'uri' key property (see
        # https://cloud.google.com/generative-ai-app-builder/docs/evaluate-search-quality)
        cdoc_url = {
          type        = "string"
          retrievable = true
        }
        # The main title (shown in search results)
        title = {
          type               = "string"
          keyPropertyMapping = "title"
          retrievable        = true
        }
        # A short description (shown in search results)
        description = {
          type               = "string"
          keyPropertyMapping = "description"
          retrievable        = true
        }
        # Metadata that is only used for debugging purposes
        debug = {
          type        = "object"
          retrievable = false
          properties = {
            # Incrementing version number of an export run from Publishing API
            payload_version = {
              type = "integer"
            }
            # Timestamp of when this document was last synced to Vertex
            last_synced_at = {
              type = "string"
            }
          }
        }
      }
    }
  })

  # VAIS adds some "output-only" properties dynamically, which creates false positive drift.
  # Terraform also alphabetises the properties, which again causes false positive drift (as VAIS
  # returns them in undefined order)
  ignore_changes_to = [
    "fieldConfigs",
    "structSchema",
    "name"
  ]
}