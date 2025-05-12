resource "aws_acm_certificate" "internal_cert" {
  domain_name       = "*.${data.tfe_outputs.vpc.nonsensitive_values.internal_root_domain_name}"
  validation_method = "DNS"
  lifecycle { create_before_destroy = true }
  tags = { Name = data.tfe_outputs.vpc.nonsensitive_values.internal_root_domain_name }
}

# this will wait until validation record is added to DNS (GoDaddy)
resource "aws_acm_certificate_validation" "internal_cert" {
  certificate_arn = aws_acm_certificate.internal_cert.arn
}