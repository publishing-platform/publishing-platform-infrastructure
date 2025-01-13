resource "aws_wafv2_web_acl" "backend_public" {
  name  = "backend_public_web_acl"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  # this rule matches any request that contains the header X-Always-Block: true
  # we can use it as a simple sanity check / acceptance test to ensure that
  # the waf is enabled and processing requests
  rule {
    name     = "x-always-block_web_acl_rule"
    priority = 10

    override_action {
      none {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.x_always_block.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "x-always-block-rule-group"
      sampled_requests_enabled   = true
    }
  }

  # This rule is intended for monitoring only
  # set a base rate limit per IP looking back over the last 5 minutes
  # this is checked every 30s
  rule {
    name     = "backend-public-base-rate-warning"
    priority = 30

    action {
      count {}
    }

    statement {
      rate_based_statement {
        limit              = var.backend_public_base_rate_warning
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "backend-public-base-rate-warning"
      sampled_requests_enabled   = true
    }
  }

  # set a base rate limit per IP looking back over the last 5 minutes
  # this is checked every 30s
  rule {
    name     = "backend-public-base-rate-limit"
    priority = 40

    action {
      block {
        custom_response {
          response_code = 429

          response_header {
            name  = "Retry-After"
            value = 30
          }

          response_header {
            name  = "Cache-Control"
            value = "max-age=0, private"
          }

          custom_response_body_key = "backend-public-rule-429"
        }
      }
    }

    statement {
      rate_based_statement {
        limit              = var.backend_public_base_rate_limit
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "backend-public-base-rate-limit"
      sampled_requests_enabled   = true
    }
  }

  dynamic "rule" {
    for_each = var.backend_public_ja3_denylist
    iterator = signature

    content {
      name = "deny-ja3-${signature.value}"

      # All rules require a unique priority, and the size of the JA3 denylist is potentially unbounded,
      # so we add these rules to the end of the list to avoid collisions.
      priority = 50 + signature.key

      action {
        block {}
      }

      statement {
        byte_match_statement {
          positional_constraint = "EXACTLY"
          search_string         = signature.value

          field_to_match {
            ja3_fingerprint {
              fallback_behavior = "NO_MATCH"
            }
          }

          text_transformation {
            type     = "NONE"
            priority = 0
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "deny-ja3-${signature.value}"
        sampled_requests_enabled   = true
      }
    }
  }

  custom_response_body {
    key     = "backend-public-rule-429"
    content = <<HTML
      <!DOCTYPE html>
      <html>
        <head>
          <title>Welcome to Publishing Platform</title>
          <style>
          </style>
        </head>
        <body>
          <header><h1>Publishing Platform</h1></header>
          <p>Sorry, there have been too many attempts to access this page.</p>
          <p>Try again in a few minutes.</p>
        </body>
      </html>
      HTML

    content_type = "TEXT_HTML"
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "backend-public-web-acl"
    sampled_requests_enabled   = true
  }
}
