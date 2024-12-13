# Prerequisite Secrets

The platform requires some prerequisite secrets in order to fully function.
These secrets are stored in AWS Secret Manager, further info about the integration
of the k8s platform platform with AWS Secret Manager is available [here](kubernetes-external-secrets.md)

The secrets listed here are either:
1. externally generated in external systems and imported into our platform. E.g.
   GitHub OAUTH secret; or
2. generated manually and used between different components of our platform.
   We don't have a method yet to autogenerate these. E.g. OAUTH shared secret between
   ArgoCD (continuous delivery tool) and Dex (federated OpenID Connect provider).
3. Publishing Platform app specific secrets which are referred to in [app-config](https://github.com/publishing-platform/publishing-platform-helm-charts/tree/main/charts/app-config)

The canonical source of all the platform secrets required are listed
[here](https://github.com/publishing-platform/publishing-platform-helm-charts/tree/main/charts/cluster-secrets/templates)
in the [publishing-platform-helm-charts] GitHub repository.

The purpose of this document is to provide information about:
1. how these secrets are generated/obtained exactly
2. the JSON format to use when adding the secrets to AWS Secret Manager

The format of secret is given below to aid creation from scratch:  
`name of the secret in AWS Secrets Manager`: Description

```
{
  <key_1>: <secret_1>,
  <key_2>: <secret_2>
}
```

In addition, there are


## Externally generated platform secrets


1. `publishing-platform/dex/github`: shared OAUTH secret between Dex and GitHub.
   Created via GitHub admin portal.

   ```
   {
     "clientID": "<secret_1>",
     "clientSecret": "<secret_2>"
   }
   ```
2. `publishing-platform/github/publishing-platform-ci`: used by ArgoCD to access Publishing Platform GitHub repos.
   Created via GitHub portal of user `publishing-platform-ci`.

   ```
   {
     "token": "<secret_1>",
     "username": "publishing-platform-ci"
   }
   ```   

## Manually generated platform secrets

1. `publishing-platform/dex/argocd`: shared OAUTH secret between Dex and ArgoCD.
    Can be generated manually using for example `openssl rand -hex 16`.

   ```
   {
     "clientID": "<secret_1>",
     "clientSecret": "<secret_2>"
   }
   ```

2. `publishing-platform/dex/argo-workflows`: shared OAUTH secret between Dex and Argo-workflows.
   Can be generated manually using for example `openssl rand -hex 16`.

   ```
   {
     "clientID": "<secret_1>",
     "clientSecret": "<secret_2>"
   }
   ```

3. `publishing-platform/dex/grafana`: shared OAUTH secret between Dex and Grafana.
   Can be generated manually using for example `openssl rand -hex 16`.

    ```
    {
      "clientID": "<secret_1>",
      "clientSecret": "<secret_2>"
    }
    ```

4. `publishing-platform/dex/alert-manager`: shared OAUTH secret between Dex and Alert Manager.
   Can be generated manually using for example `openssl rand -hex 16`.

   ```
   {
     "clientID": "<secret_1>",
     "clientSecret": "<secret_2>",
     "cookieSecret": "<secret_3>"
   }
   ```

5. `publishing-platform/dex/prometheus`: shared OAUTH secret between Dex and Prometheus.
  Can be generated manually using for example `openssl rand -hex 16`.

  ```
  {
    "clientID": "<secret_1>",
    "clientSecret": "<secret_2>",
    "cookieSecret: <secret_3>
  }
  ```

[publishing-platform-helm-charts]: https://github.com/publishing-platform/publishing-platform-helm-charts