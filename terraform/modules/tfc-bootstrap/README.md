# tfc-bootstrap

The `tfc-bootstrap` module bootstraps Terraform Cloud and creates the `tfc-configuration` workspace which manages the other Terraform module workspaces.

You must apply this module locally.

1. In a web browser login to Terraform Cloud and create a new workspace called tfc-bootstrap.
2. In your terminal login to Terraform Cloud

    ```
    $ terraform login
    ```

3. Run Terraform init

    ```
    $ cd terraform/modules/tfc-bootstrap
    $ terraform init
    ```

4. Run terraform plan

    ```
    $ terraform plan -out tfc-bootstrap.tfplan
    ```

5. Apply the plan

    ```
    $ terraform apply tfc-bootstrap.tfplan
    ```
