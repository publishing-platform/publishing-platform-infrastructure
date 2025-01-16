resource "aws_security_group" "rds" {
  for_each = var.databases

  name        = "${each.value.name}_rds_access"
  vpc_id      = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  description = "Access to ${each.value.name} RDS"
  tags        = { Name = "${each.value.name}_rds_access" }
}

# Moved to rds-security temporarily to decouple rds and cluster-infrastructure modules
# resource "aws_security_group_rule" "postgres" {
#   for_each          = { for name, data in var.databases : name => data if data.engine == "postgres" }
#   security_group_id = aws_security_group.rds[each.key].id
#   description       = "Access to PostgreSQL database from EKS worker nodes"

#   type      = "ingress"
#   protocol  = "tcp"
#   from_port = 5432
#   to_port   = 5432

#   source_security_group_id = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.node_security_group_id
# }