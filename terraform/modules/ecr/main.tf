data "github_repositories" "publishing_platform" {
  query = "org:publishing-platform topic:container topic:publishing-platform fork:false archived:false"
}

output "variable_set_id" {
  value = data.github_repositories.publishing_platform.names
}