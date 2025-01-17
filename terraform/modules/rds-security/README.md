# rds-security

The purpose of this module is to decouple the [`rds`](./modules/rds/) and [`cluster-infrastructure`](./modules/cluster-infrastructure/) modules. It is a temporary solution to allow tear-down of the `cluster-infrastructure` module independently of the `rds` module. 

This module contains the security group rules that allow EKS nodes to access RDS instances.