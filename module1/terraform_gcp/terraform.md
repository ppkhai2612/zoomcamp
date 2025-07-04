# Terraform

### Introduction

Defition, Workflow and Commands : https://phuockhai.notion.site/Terraform-2101e0bbbf3980309694f0f09204f614

Demo: run the following commands to implement a Terraform workflow

- `terraform init`: create *.terraform* folder and *hcl* file from *.tf* file

- `terraform plan`

   *Firstly need to authenticate to access to GCP resources: [authentication](#authentication)

- `terraform apply`: Create *.tfstate* file which saving current Terraform state

- `terraform destroy` Create *.tfstate.backup* file which backup terraform state   

Sample terraform folders to test:

- Basic version: [terraform_basic](terraform_basic/)
- Variable version: [terraform_variable](terraform_variable/)
   
### Google Cloud Platform (GCP)

GCP basics at: https://phuockhai.notion.site/Google-Cloud-Platform-GCP-2101e0bbbf3980a5ae83f7bf61b91097?pvs=74

- Create project on GCP
- Create service account, assign roles (Storage Admin, Big Query Admin, Compute Admin), create and store key

### Authentication

There are 3 ways to authenticate

1. Use GOOGLE_APPLICATION_CREDENTIALS env var: `export GOOGLE_APPLICATION_CREDENTIALS='/d/zoomcamp/module1/terraform_gcp/keys/credentials.json'`
2. Use Service Account to authenticate: `gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS`
3. Use Google Account to authenticate: `gcloud auth application-default login`
   
   If you get a message like quota exceeded, then run:

   `PROJECT_NAME="zoomcamp-terraform"`
   
   `gcloud auth application-default set-quota-project ${PROJECT_NAME}`

*To authenticate by the second or third way, firstly install Google Cloud CLI via https://cloud.google.com/sdk/docs/install-sdk*


   
         
