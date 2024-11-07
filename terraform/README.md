# Terraform for Publishing Platform EKS cluster

## Applying Terraform
When turning up from scratch, deploy the modules in this order:

1. [`tfc-aws-config`](./modules/tfc-aws-config/)
2. [`tfc-bootstrap`](./modules/tfc-bootstrap/)
3. [`tfc-configuration`](./modules/tfc-configuration/)
4. [`vpc`](./modules/vpc/)
5. [`cluster-infrastructure`](./modules/cluster-infrastructure/)
6. TODO