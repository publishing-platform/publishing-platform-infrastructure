# Publishing Platform Infrastructure

## What's in this repo

The publishing-platform-infrastructure repo contains:

- [`terraform/`](terraform/): Terraform modules for turning up an Kubernetes
  cluster on EKS for the Publishing Platform.
- [`images/`](images/): Container image definitions for utilities such as the _toolbox_ image.
- [`.github/`](.github/): GitHub Actions and workflows used by other Publishing Platform
  repos, for example release automation, test runners and security analysis
  tools.

### What's not in this repo

Helm charts for Publishing Platform applications are in [publishing-platform/publishing-platform-helm-charts](https://github.com/publishing-platform/publishing-platform-helm-charts).

Base image definitions for Publishing Platform Ruby apps are in [publishing-platform/publishing-platform-ruby-images](https://github.com/publishing-platform/publishing-platform-ruby-images/).
