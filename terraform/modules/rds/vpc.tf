# vpc.tf manages the subnets for the RDS instances and their associated
# paraphernalia. The VPC itself is defined in ../vpc

resource "aws_subnet" "rds_private" {
  for_each          = var.rds_private_subnets
  vpc_id            = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = "publishing-platform-rds-private-${each.key}"
  }
}

resource "aws_route_table" "rds_private" {
  for_each = var.rds_private_subnets
  vpc_id   = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  tags     = { Name = "publishing-platform-rds-private-${each.key}" }
}

resource "aws_route_table_association" "rds_private" {
  for_each       = var.rds_private_subnets
  subnet_id      = aws_subnet.rds_private[each.key].id
  route_table_id = aws_route_table.rds_private[each.key].id
}