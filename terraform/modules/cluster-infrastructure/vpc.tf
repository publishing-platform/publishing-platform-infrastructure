# vpc.tf manages the subnets for the EKS cluster and their associated
# paraphernalia such as NAT gateways and route tables. The VPC itself is
# defined in ../vpc

locals {
  route_create_timeout = "5m" # Same workaround as terraform-aws-vpc module.
}

# Control plane subnets and associated resources. The control plane subnets are
# small, private subnets where EKS creates the ENIs for private access to
# the master node, which runs in an Amazon-owned VPC.

resource "aws_subnet" "eks_control_plane" {
  for_each          = var.eks_control_plane_subnets
  vpc_id            = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags              = { Name = "${var.cluster_name}-eks-control-plane-${each.key}" }
}

resource "aws_route_table" "eks_control_plane" {
  for_each = var.eks_control_plane_subnets
  vpc_id   = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  tags     = { Name = "${var.cluster_name}-eks-control-plane-${each.key}" }
}

resource "aws_route_table_association" "eks_control_plane" {
  for_each       = var.eks_control_plane_subnets
  subnet_id      = aws_subnet.eks_control_plane[each.key].id
  route_table_id = aws_route_table.eks_control_plane[each.key].id
}

# resource "aws_route" "eks_control_plane_nat" {
#   for_each               = var.eks_control_plane_subnets
#   route_table_id         = aws_route_table.eks_control_plane[each.key].id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.eks[each.key].id
#   timeouts {
#     create = local.route_create_timeout
#   }
# }

# Public subnets and associated resources. The public subnets are used by
# controllers in the cluster (such as aws-load-balancer-controller) for
# creating Internet-facing load balancers.

# TODO...............................


# Private subnets and associated resources. The private subnets contain the
# worker nodes and the pods.

# TODO...............................