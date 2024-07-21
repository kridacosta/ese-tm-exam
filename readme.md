## Contents

### Terraform

The `terraform` directory contains Terraform configuration files and modules for provisioning various cloud resources.

- **main.tf**: Main Terraform configuration file.
- **outputs.tf**: Defines outputs for Terraform configurations.
- **variables.tf**: Defines input variables for Terraform configurations.
- **tfvars/stg.tfvars**: Variables specific to the staging environment.
- **modules/**: Contains reusable Terraform modules for different services:
  - **dataflow**: Terraform module for Google Cloud Dataflow.
  - **compute-engine**: Terraform module for Google Compute Engine.
  - **bigquery**: Terraform module for Google BigQuery.
  - **vertexai**: Terraform module for Google Vertex AI.
  - **cloud-storage**: Terraform module for Google Cloud Storage.
  - **cloud-sql**: Terraform module for Google Cloud SQL.

### CDC (Change Data Capture)

The `cdc` directory contains scripts related to change data capture.

- **publish.py**: Script for publishing changes to a message broker or other service.

### Dataflow Job

The `dataflow-job` directory contains code for a Dataflow job.

- **deploy.sh**: Script to deploy the Dataflow job.
- **mt_to_dw.py**: Python script for the Dataflow job.
- **params.yaml**: Configuration parameters for the Dataflow job.
- **requirements.txt**: Python dependencies for the Dataflow job.
- **setup.py**: Setup script for the Dataflow job.
- **README.md**: Documentation for the Dataflow job.
- **.gitignore**: Git ignore file for the Dataflow job directory.

### SQL Queries

The `queries` directory contains SQL scripts.

- **create_customer_table.sql**: SQL script to create a customer table.
- **create_insert_trigger.sql**: SQL script to create an insert trigger.
- **notify_sp.sql**: SQL script for a stored procedure to notify changes.

## Getting Started

To get started with this repository, follow the instructions below:

1. **Clone the repository:**

    ```sh
    git clone <repository-url>
    cd ese-hendrickacosta-exam
    ```

2. **Set up Terraform:**

    Navigate to the `terraform` directory and initialize Terraform:

    ```sh
    cd terraform
    terraform init
    ```

3. **Deploy the infrastructure:**

    Apply the Terraform configurations:

    ```sh
    terraform apply -var-file=tfvars/stg.tfvars
    ```

4. **Deploy the Dataflow job:**

    Navigate to the `dataflow-job` directory and run the deployment script:

    ```sh
    cd ../dataflow-job
    ./deploy.sh
    ```