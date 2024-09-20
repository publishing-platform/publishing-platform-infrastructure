# Applying Terraform

## Bootstrapping Terraform Cloud

The [`tfc-bootstrap`](../modules/tfc-bootstrap) module bootstraps Terraform Cloud and creates the `tfc-configuration` workspace which manages the other Terraform module workspaces.

1. In a web browser login to Terraform Cloud and create a new workspace called tfc-bootstrap.
2. Create a short lived API token (Account Settings > Tokens)
3. In the tfc-bootstrap workspace add an environment variable called `TFE_TOKEN` with the value of the API token generated in the previous step.
4. Run Terraform init

    ```
    $ cd terraform/modules/tfc-bootstrap
    $ terraform init
    ```

5. Run terraform plan

    ```
    $ terraform plan -ou tfc-bootstrap.tfplan
    ```

6. Apply the plan

    ```
    $ terraform apply tfc-bootstrap.tfplan
    ```
