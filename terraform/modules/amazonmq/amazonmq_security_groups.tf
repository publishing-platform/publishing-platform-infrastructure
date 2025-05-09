resource "aws_security_group" "rabbitmq" {
  name        = "publishing_platform_rabbitmq_access"
  vpc_id      = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  description = "Access to the rabbitmq host from its ELB"
}