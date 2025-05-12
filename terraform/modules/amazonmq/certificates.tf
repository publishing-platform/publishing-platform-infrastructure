locals {
  internal_dns_zone_name = "${var.publishing_platform_environment}.publishing-platform-internal.top"
}


resource "aws_acm_certificate" "internal_cert" {
  domain_name       = "*.${local.internal_dns_zone_name}"
  validation_method = "DNS"
  lifecycle { create_before_destroy = true }
  tags = { Name = local.internal_dns_zone_name }
}

# See
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation#dns-validation-with-route-53
resource "aws_route53_record" "internal_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.internal_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.tfe_outputs.vpc.nonsensitive_values.internal_root_zone_id
}

resource "aws_acm_certificate_validation" "internal_cert" {
  certificate_arn = aws_acm_certificate.internal_cert.arn
}