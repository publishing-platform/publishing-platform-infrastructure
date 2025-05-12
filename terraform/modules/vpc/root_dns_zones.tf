# Creates the internal and external root DNS zones.

resource "aws_route53_zone" "internal_root_zone" {
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