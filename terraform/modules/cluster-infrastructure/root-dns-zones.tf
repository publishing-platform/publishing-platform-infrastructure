# Creates the internal and external root DNS zones.

# resource "aws_route53_zone" "internal_root_zone" {
#   name          = "${var.publishing_platform_environment}.${var.internal_root_domain_name}"
#   force_destroy = var.force_destroy
# }

resource "aws_route53_zone" "external_root_zone" {
  name          = "${var.publishing_platform_environment}.${var.external_root_domain_name}"
  force_destroy = var.force_destroy
}