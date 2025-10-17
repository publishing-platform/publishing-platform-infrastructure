# Creates and configures service accounts, IAM roles, role bindings, and keys for `search-api` to
# be able to access the Discovery Engine API.
resource "google_service_account" "api" {
  account_id   = "search-api"
  display_name = "search-api (Rails API app and document sync worker)"
  description  = "Service account to provide access to the search-api Rails app and document sync worker"
}

resource "google_service_account_key" "api" {
  service_account_id = google_service_account.api.id
}

resource "google_project_iam_custom_role" "api" {
  role_id     = "search_api"
  title       = "search-api"
  description = "Provides the required permissions for Search API to access Discovery Engine"

  permissions = [
    "discoveryengine.dataStores.completeQuery",
    "discoveryengine.dataStores.get",
    "discoveryengine.documents.create",
    "discoveryengine.documents.delete",
    "discoveryengine.documents.get",
    "discoveryengine.documents.import",
    "discoveryengine.documents.list",
    "discoveryengine.documents.update",
    "discoveryengine.evaluations.create",
    "discoveryengine.evaluations.get",
    "discoveryengine.operations.get",
    "discoveryengine.sampleQueries.import",
    "discoveryengine.sampleQuerySets.create",
    "discoveryengine.sampleQuerySets.delete",
    "discoveryengine.sampleQuerySets.get",
    "discoveryengine.servingConfigs.search",
    "discoveryengine.suggestionDenyListEntries.import",
    "discoveryengine.suggestionDenyListEntries.purge",
    "discoveryengine.userEvents.import",
    "discoveryengine.userEvents.purge",
  ]
}

resource "google_project_iam_binding" "api" {
  project = data.tfe_outputs.tfc_gcp_config.nonsensitive_values.gcp_project_id
  role    = google_project_iam_custom_role.api.id

  members = [
    google_service_account.api.member
  ]
}