locals {
  repositories = concat(
    local.extra_repositories,
    data.github_repositories.publishing_platform.names
  )

  extra_repositories = [
    "toolbox"
  ]
}