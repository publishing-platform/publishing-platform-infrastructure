# vpc.tf in publishing-infrastructure

resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  vpc_id            = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = "publishing-platform-private-${each.key}"
  }
}

resource "aws_route_table" "private" {
  for_each = var.private_subnets
  vpc_id   = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  tags     = { Name = "publishing-platform-private-${each.key}" }
}

resource "aws_route_table_association" "private" {
  for_each       = var.private_subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}