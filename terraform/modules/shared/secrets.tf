# Amazon MQ user passwords
# TODO: move to publishing-infrastructure
resource "random_password" "mq_user" {
  for_each = toset([
    "root",
    "publishing_api",
    "search_api",
  ])
  length           = 24
  override_special = "!@#$%&*()-_+[]{}<>?"
  min_special      = 2
}