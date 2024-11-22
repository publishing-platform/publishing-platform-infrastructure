resource "sentry_project" "publishing_platform" {
  for_each = local.sentry_projects

  organization = "publishing-platform"

  teams = local.common_teams
  name  = each.key
  slug  = "app-${each.key}"

  platform = "ruby"

  default_rules = false
  default_key   = true
}