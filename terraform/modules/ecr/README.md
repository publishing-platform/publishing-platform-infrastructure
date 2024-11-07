# Elastic Container Registry for Publishing Platform in Kubernetes

Container images for Publishing Platform on Kubernetes are stored in AWS ECR. The registry
is hosted in the Publishing Platform production AWS account.

All accounts/environments use the **production** ECR. This is because there
would be no real benefit to having multiple registries but considerable
complexity in copying images around between registries.