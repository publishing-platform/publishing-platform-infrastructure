resource "aws_sns_topic" "rds_alerts" {
  name         = "publishing-platform-rds-alerts"
  display_name = "Publishing Platform RDS Alerts"
}

resource "aws_sns_topic_subscription" "rds_alerts" {
  topic_arn = aws_sns_topic.rds_alerts.arn
  protocol  = "email"
  endpoint  = var.rds_alerts_email_address
}

resource "aws_sns_topic" "rds_events" {
  name         = "publishing-platform-rds-events"
  display_name = "Publishing Platform RDS Events"
}

resource "aws_db_event_subscription" "rds_events" {
  name      = "publishing-platform-rds-events-sub"
  sns_topic = aws_sns_topic.rds_events.arn

  source_type = "db-instance"
  source_ids  = [for i in aws_db_instance.instance : i.identifier]

  event_categories = [
    "availability",
    "deletion",
    "failure",
    "low storage",
  ]
}

# Alarm if free storage space is below threshold (typically 10 GiB) for 10m.
resource "aws_cloudwatch_metric_alarm" "rds_freestoragespace" {
  for_each   = var.databases
  dimensions = { DBInstanceIdentifier = aws_db_instance.instance[each.key].identifier }

  alarm_name          = "${aws_db_instance.instance[each.key].identifier}-rds-freestoragespace"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "10"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Minimum"
  threshold           = each.value.freestoragespace_threshold
  alarm_actions       = [aws_sns_topic.rds_alerts.arn]
  alarm_description   = "Available storage space on ${aws_db_instance.instance[each.key].identifier} RDS is too low."
}