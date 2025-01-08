data "github_repositories" "publishing_platform" {
  query = "topic:publishing-platform org:publishing-platform archived:false"
}

resource "github_team" "publishing_platform_ci_bots" {
  name        = "Publishing Platform CI Bots"
  privacy     = "closed"
  description = "Contains the `publishing-platform-ci` user and grants it admin access to all Publishing Platform repos"
}

resource "github_team" "publishing_platform_production_admin" {
  name    = "Publishing Platform Production Admin"
  privacy = "closed"
}

resource "github_team" "publishing_platform_production_deploy" {
  name    = "Publishing Platform Production Deploy"
  privacy = "closed"
}

resource "github_team" "publishing_platform" {
  name    = "Publishing Platform"
  privacy = "closed"
}

resource "github_team_repository" "publishing_platform_ci_bots_admin_repos" {
  for_each   = toset(data.github_repositories.publishing_platform.names)
  repository = each.value
  team_id    = github_team.publishing_platform_ci_bots.id
  permission = "admin"
}

resource "github_team_repository" "publishing_platform_production_admin_repos" {
  for_each   = toset(data.github_repositories.publishing_platform.names)
  repository = each.value
  team_id    = github_team.publishing_platform_production_admin.id
  permission = "admin"
}

resource "github_team_repository" "publishing_platform_repos" {
  for_each   = toset(data.github_repositories.publishing_platform.names)
  repository = each.value
  team_id    = github_team.publishing_platform.id
  permission = "push"
}