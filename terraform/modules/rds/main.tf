resource "random_string" "database_password" {
  for_each = var.databases

  length  = 32
  special = false
  lifecycle { ignore_changes = [length, special] }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "publishing-platform-rds-subnet-group"
  subnet_ids = [for s in aws_subnet.rds_private : s.id]

  tags = { Name = "publishing-platform-rds-subnet-group" }
}

resource "aws_db_parameter_group" "engine_params" {
  for_each = var.databases

  name_prefix = "${each.value.name}-${each.value.engine}-"
  family      = merge({ engine_params_family = "${each.value.engine}${each.value.engine_version}" }, each.value)["engine_params_family"]

  dynamic "parameter" {
    for_each = each.value.engine_params

    content {
      name         = parameter.key
      value        = parameter.value.value
      apply_method = merge({ apply_method = "immediate" }, parameter.value)["apply_method"]
    }
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_db_instance" "instance" {
  for_each = var.databases

  engine                  = each.value.engine
  engine_version          = each.value.engine_version
  username                = var.database_admin_username
  password                = random_string.database_password[each.key].result
  allocated_storage       = each.value.allocated_storage
  instance_class          = each.value.instance_class
  identifier              = "${each.value.name}-${each.value.engine}"
  storage_type            = "gp3"
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  multi_az                = var.multi_az
  parameter_group_name    = aws_db_parameter_group.engine_params[each.key].name
  maintenance_window      = var.maintenance_window
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  copy_tags_to_snapshot   = true
  vpc_security_group_ids  = [aws_security_group.rds[each.key].id]
  ca_cert_identifier      = "rds-ca-rsa2048-g1"
  apply_immediately       = var.apply_immediately

  performance_insights_enabled          = each.value.performance_insights_enabled
  performance_insights_retention_period = each.value.performance_insights_enabled ? 7 : 0

  timeouts {
    create = var.terraform_create_rds_timeout
    delete = var.terraform_delete_rds_timeout
    update = var.terraform_update_rds_timeout
  }

  deletion_protection       = var.deletion_protection
  final_snapshot_identifier = "${each.value.name}-final-snapshot"
  skip_final_snapshot       = var.skip_final_snapshot

  tags = { Name = "publishing-platform-rds-${each.value.name}-${each.value.engine}", project = lookup(each.value, "project", "Publishing Platform - Other") }
}

resource "aws_route53_record" "instance_cname" {
  for_each = var.databases

  # Zone is <environment>.publishing-platform.top
  zone_id = data.tfe_outputs.vpc.nonsensitive_values.internal_root_zone_id
  name    = "${each.value.name}-${each.value.engine}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.instance[each.key].address]
}

resource "aws_secretsmanager_secret" "database_passwords" {
  name = "rds-admin-passwords"
}

resource "aws_secretsmanager_secret_version" "database_passwords" {
  secret_id = aws_secretsmanager_secret.database_passwords.id
  secret_string = jsonencode(
    { for k, v in random_string.database_password : k => v.result }
  )
}
