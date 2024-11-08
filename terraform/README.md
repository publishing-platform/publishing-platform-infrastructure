# Terraform for Publishing Platform EKS cluster

## Applying Terraform
When turning up from scratch, deploy the modules in this order:

1. [`tfc-bootstrap`](./modules/tfc-bootstrap/) (execute locally)
2. [`tfc-configuration`](./modules/tfc-configuration/)
3. [`tfc-aws-config`](./modules/tfc-aws-config/) (execute locally)
4. [`vpc`](./modules/vpc/)
5. [`github`](./modules/github/)
6. [`ecr`](./modules/ecr/)
5. [`cluster-infrastructure`](./modules/cluster-infrastructure/)
6. TODO