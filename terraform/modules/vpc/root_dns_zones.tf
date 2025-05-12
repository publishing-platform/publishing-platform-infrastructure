# Creates the internal and external root DNS zones.

variable "create_internal_zone_dns_validation" {
  type        = string
  description = "Create a public DNS zone to validate the internal domain certificate (default false)"
  default     = false
}

resource "aws_route53_zone" "internal_root_zone" {
  count         = var.create_internal_zone_dns_validation ? 1 : 0
  name          = "${var.publishing_platform_environment}.publishing-platform-internal.top"
  force_destroy = var.force_destroy

  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}

resource "aws_route53_zone" "external_root_zone" {
  name          = "${var.publishing_platform_environment}.publishing-platform.top"
  force_destroy = var.force_destroy
}