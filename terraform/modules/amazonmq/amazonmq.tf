locals {
  mq_instance_count = {
    SINGLE_INSTANCE         = 1
    ACTIVE_STANDBY_MULTI_AZ = 2
    CLUSTER_MULTI_AZ        = 3
  }[var.amazonmq_deployment_mode]
}

resource "random_password" "mq_user" {
  for_each = toset([
    "root",
  ])
  length = 24
}

resource "aws_mq_broker" "publishing_amazonmq" {
  broker_name = "PublishingMQ"

  engine_type         = "RabbitMQ"
  engine_version      = var.amazonmq_engine_version
  deployment_mode     = var.amazonmq_deployment_mode
  host_instance_type  = var.amazonmq_host_instance_type
  publicly_accessible = false
  # use the existing RabbitMQ security group. We can move it
  # over to this module at the point of migration
  # security_groups = [aws_security_group.rabbitmq.id] # NH TODO: uncomment
  subnet_ids = (
    var.amazonmq_deployment_mode == "SINGLE_INSTANCE"
    ? [aws_subnet.private[0].id]
    : [for s in aws_subnet.private : s.id]
  )

  auto_minor_version_upgrade = true
  maintenance_window_start_time {
    day_of_week = var.amazonmq_maintenance_window_start_day_of_week
    time_of_day = var.amazonmq_maintenance_window_start_time_utc
    time_zone   = "UTC"
  }

  logs { general = true }

  # The Terraform provider can only create a single user.
  user {
    console_access = true
    username       = "root"
    password       = random_password.mq_user["root"].result
  }
}