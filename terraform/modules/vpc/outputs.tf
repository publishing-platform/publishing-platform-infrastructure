output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.public.id
  description = "The ID of the Internet Gateway."
}

output "internal_root_zone_id" {
  description = "ID of the internal Route53 DNS zone"
  value       = aws_route53_zone.internal_root_zone.id
}

output "internal_root_domain_name" {
  description = "Name of the internal Route53 DNS zone"
  value       = aws_route53_zone.internal_root_zone.name
}

output "external_root_zone_id" {
  description = "ID of the external Route53 DNS zone"
  value       = aws_route53_zone.external_root_zone.id
}

output "external_root_domain_name" {
  description = "Name of the external Route53 DNS zone"
  value       = aws_route53_zone.external_root_zone.name
}