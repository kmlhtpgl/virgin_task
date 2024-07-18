# Terraform Cloud Run Deployment

## Overview
This repository contains Terraform configuration files to deploy a "Hello World" service on Google Cloud Run, setup a service account, and allow dynamic deployments across multiple GCP projects.

## Prerequisites
- Google Cloud account with a project and billing enabled.
- Terraform installed on your local machine.

## Usage

1. **Clone the repository**
   ```sh
   git clone https://github.com/kmlhtpgl/virgin_task.git
2. **Change to the Repository Directory**  
   Navigate to the cloned repository:
   cd virgin_task
3. **Configure Google Cloud SDK**
   Authenticate with your Google Cloud account using the gcloud tool:
   gcloud auth application-default login
4. **Enable Required APIs(If needed)**
   Enable the necessary APIs for your Google Cloud project:
   gcloud services enable run.googleapis.com
   gcloud services enable iam.googleapis.com
5. **Set Up Environment Variables**
   Create environment-specific variable files in the envs directory. For example, create envs/dev/terraform.tfvars with the following content:
      project_id = "your-dev-project-id"
      region     = "us-central1"
6. **Initialize Terraform**
   terraform init
7. **Deploy to an Environment**
   Use the provided deployment script to deploy the Hello World app to a specific environment. For example, to deploy to the dev environment:

   ./scripts/deploy.sh dev
8. **Accessing the Deployed Service**
After the deployment completes, you can find the URL of the deployed Cloud Run service in the Terraform output. To view this, you can use:
   terraform output cloud_run_url

