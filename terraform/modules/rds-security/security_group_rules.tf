resource "aws_security_group_rule" "postgres" {
  for_each          = { for name, data in var.databases : name => data if data.engine == "postgres" }
  security_group_id = data.tfe_outputs.rds.nonsensitive_values.rds_security_groups[each.key]
  description       = "Access to PostgreSQL database from EKS worker nodes"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  source_security_group_id = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.node_security_group_id
}