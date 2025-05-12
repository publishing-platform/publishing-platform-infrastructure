locals {
  mq_instance_count = {
    SINGLE_INSTANCE         = 1
    ACTIVE_STANDBY_MULTI_AZ = 2
    CLUSTER_MULTI_AZ        = 3
  }[var.amazonmq_deployment_mode]
}

data "aws_acm_certificate" "internal_cert" {
  domain   = "*.${var.publishing_platform_environment}.publishing-platform-internal.top"
  statuses = ["ISSUED"]
}

data "aws_vpc_endpoint" "mq" {
  depends_on = [aws_mq_broker.publishing_amazonmq]
  vpc_id     = data.tfe_outputs.vpc.nonsensitive_values.id
  tags       = { Broker = aws_mq_broker.publishing_amazonmq.id }
}

data "aws_network_interface" "mq" {
  count = local.mq_instance_count
  id    = sort(tolist(data.aws_vpc_endpoint.mq.network_interface_ids))[count.index]
}

resource "random_password" "mq_user" {
  for_each = toset([
    "root",
  ])
  length           = 24
  override_special = "!@#$%&*()-_+[]{}<>?"
  min_special      = 2
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
  security_groups = [aws_security_group.rabbitmq.id]
  subnet_ids = (
    var.amazonmq_deployment_mode == "SINGLE_INSTANCE"
    ? [aws_subnet.private[keys(var.private_subnets)[0]].id]
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

resource "aws_lb" "publishingmq_lb_internal" {
  name               = "publishingamazonmq-lb-internal"
  tags               = { "Name" = "publishingamazonmq-lb-internal" }
  internal           = true
  load_balancer_type = "network"
  subnets            = aws_mq_broker.publishing_amazonmq.subnet_ids

  access_logs {
    bucket = "publishing-platform-${var.publishing_platform_environment}-aws-logging"
    prefix = "lb/publishingamazonmq-internal-lb"
  }
}

resource "aws_lb_listener" "internal_https" {
  load_balancer_arn = aws_lb.publishingmq_lb_internal.arn
  port              = "443"
  protocol          = "TLS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = data.aws_acm_certificate.internal_cert.arn
  tags              = { Description = "MQ admin web UI" }

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_https.arn
  }
}

resource "aws_lb_target_group" "internal_https" {
  name        = "publishingmq-lb-internal-https"
  target_type = "ip"
  port        = 443
  protocol    = "TLS"
  vpc_id      = data.tfe_outputs.vpc.nonsensitive_values.id

  health_check {
    path     = "/"
    protocol = "HTTPS"
  }
}

resource "aws_lb_target_group_attachment" "internal_https_ips" {
  count = local.mq_instance_count
  depends_on = [
    aws_mq_broker.publishing_amazonmq,
    aws_lb_target_group.internal_https,
  ]
  target_group_arn = aws_lb_target_group.internal_https.arn
  target_id        = data.aws_network_interface.mq[count.index].private_ip
  port             = 443
}

resource "aws_lb_listener" "internal_amqps" {
  load_balancer_arn = aws_lb.publishingmq_lb_internal.arn
  port              = "5671"
  protocol          = "TLS"
  certificate_arn   = data.aws_acm_certificate.internal_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_amqps.arn
  }
}

resource "aws_lb_target_group" "internal_amqps" {
  name        = "publishingmq-lb-internal-amqps"
  target_type = "ip"
  port        = 5671
  protocol    = "TLS"
  vpc_id      = data.tfe_outputs.vpc.nonsensitive_values.id

  health_check {
    path     = "/"
    port     = 443
    protocol = "HTTPS"
  }
}

resource "aws_lb_target_group_attachment" "internal_amqps_ips" {
  count = local.mq_instance_count
  depends_on = [
    aws_mq_broker.publishing_amazonmq,
    aws_lb_target_group.internal_amqps,
  ]
  target_group_arn = aws_lb_target_group.internal_amqps.arn
  target_id        = data.aws_network_interface.mq[count.index].private_ip
  port             = 5671
}

resource "aws_route53_record" "publishing_amazonmq_internal_root_domain_name" {
  zone_id = data.tfe_outputs.root_dns.nonsensitive_values.internal_root_zone_id
  name    = "${lower(aws_mq_broker.publishing_amazonmq.broker_name)}.${var.publishing_platform_environment}.publishing-platform-internal.top"
  type    = "A"

  alias {
    name                   = aws_lb.publishingmq_lb_internal.dns_name
    zone_id                = aws_lb.publishingmq_lb_internal.zone_id
    evaluate_target_health = true
  }
}