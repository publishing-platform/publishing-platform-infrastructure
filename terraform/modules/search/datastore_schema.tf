############## DATASTORE ##############

# The data schema for the datastore
#
# The API resource relationship is one-to-many, but currently only a single schema is supported and
# it's automatically created as `default_schema` (with an empty content) on creation of the
# datastore.
#
# API resource: v1alpha.projects.locations.collections.dataStores.schemas

resource "restapi_object" "google_discovery_engine_datastore_schema" {
  path      = "/dataStores/${google_discovery_engine_data_store.publishing_platform_data_Store.data_store_id}/schemas"
  object_id = "default_schema"

  # Since the default schema is created automatically with the datastore, we need to update even on
  # initial Terraform resource creation
  create_method = "PATCH"
  create_path   = "/dataStores/${google_discovery_engine_data_store.publishing_platform_data_Store.data_store_id}/schemas/default_schema"

  data = jsonencode({
    structSchema = {
      "$schema" = "https://json-schema.org/draft/2020-12/schema"
      "$id"     = "https://www.publishing-platform.co.uk/publishing_platform_content_metadata_discoveryengine.json"
      type      = "object"
      properties = {
        # Unique content ID from the Publishing API (for debugging/retrieving single objects)
        content_id = {
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
        # URI reference either as a relative path for GOV.UK content, or as an absolute URL for
        # external content (used to link to the content from search results)
        link = {
          type        = "string"
          retrievable = true
          indexable   = true
        }
        # Absolute URL including protocol and host even for content on GOV.UK proper (used for
        # Vertex to incorporate popularity/event signals and for internal purposes)
        url = {
          type               = "string"
          retrievable        = true
          keyPropertyMapping = "uri"
        }
        # The source document type (for boosting)
        document_type = {
          type        = "string"
          indexable   = true
          retrievable = true
        }
        # The status of the organisation. Only applies to organisations.
        organisation_status = {
          type        = "string"
          retrievable = true
        }
        # The organisation type identifier, like 'department'. Only applies to organisations.
        organisation_type = {
          type        = "string"
          retrievable = true
        }
        # The organisation abbreviation, like 'ds'. Only applies to organisations.
        organisation_abbreviation = {
          type        = "string"
          retrievable = true
        }
        # Incrementing document version number (used to avoid document update race conditions)
        #
        # Note: We've decided not to use this in the end as there isn't enough of a risk and we
        # cannot guarantee atomic writes anyway. It is now included in the `debug` object field.
        # Vertex does not support removing a field from the schema (as of Jan 2024) so it stays
        # here.
        payload_version = {
          type = "integer"
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