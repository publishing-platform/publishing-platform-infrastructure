output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.public.id
  description = "The ID of the Internet Gateway."
}