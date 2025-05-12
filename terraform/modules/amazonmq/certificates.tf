locals {
  internal_root_zone = "${var.publishing_platform_environment}.publishing-platform-internal.top"
}

resource "aws_acm_certificate" "internal_cert" {
  domain_name       = "*.${local.internal_root_zone}"
  validation_method = "EMAIL" # use email validation because this is a private DNS zone
  lifecycle { create_before_destroy = true }
  tags = { Name = local.internal_root_zone }
}

# simply a waiter for manual email approval of certificate
resource "aws_acm_certificate_validation" "internal_cert" {
  certificate_arn = aws_acm_certificate.internal_cert.arn
}