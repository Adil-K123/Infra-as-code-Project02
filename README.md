# Infra-as-code-Project02

## Project Overview
This repository is my learning project for exploring Infrastructure as Code (IaC) concepts using Terraform and GitHub Actions.It demonstrates setting up and managing cloud infrastructure on AWS for a related application code project found in [App_code-Project02](https://github.com/Adil-K123/App_code-Project02).

## Features
- Infrastructure defined as code using Terraform.
- GitHub Actions workflows for CI/CD pipelines.
- Creation and implementation of AWS services (EC2, RDS, VPC, IAM ROLES, ECR etc.).
- Version-controlled infrastructure changes 
- Multi-environments set-up with common child modules stored in 'modules' directory as much as possible
- Terraform state files managed in remote Terraform Cloud backend for different environments (dev, staging, production, shared).

## Prerequisites

- Create a HashiCorp Terraform Cloud account and set up workspaces for each environment (dev, staging, prod, shared).
- Generate AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY from your AWS account and store them as sensitive environment variables in each Terraform Cloud workspace.
- Store `dbusername` and `dbpassword` for RDS as Terraform variables in Terraform Cloud workspaces as we refer that as env variables in our configurations
- Obtain an API Token from Terraform Cloud and store it as a GitHub repository secret.
- Create an SSH key pair in AWS maually and reference it in the Terraform configuration for EC2 instances (`flask_ec2`).Please note: I created only one SSH key  ("flask_ec2") for all environments and refered it in the common module for EC2
- Install Terraform locally and configure the Terraform token for planning locally if needed.
    - Create a secrets.tfvars file in each environment directory and define your database credentials.
    - Ensure to add secrets.tfvars to .gitignore to prevent sensitive data from being pushed to GitHub.

## Setting Up

- bash
- Copy code
- git clone https://github.com/Adil-K123/Infra-as-code-Project02.git
- cd Infra-as-code-Project02
- Update the organization name and workspace name in provider.tf within each environment's directory according to your Terraform Cloud setup.

## Planning

- Use TF login in the CLI of local machine https://developer.hashicorp.com/terraform/cli/commands/login
- For initialising and planning infra:
    terraform init
    terraform plan

## GitHub Actions

- CI/CD workflows defined in .github/workflows.
- Each push or pull request will trigger terraform commands on each environments
- Customize workflows to fit your deployment and testing needs.


## Add on

- Start by creating the shared environment using the workflow: This step is crucial to avoid errors in subsequent environment setups. The shared environment establishes common configurations such as IAM instance profiles, which are reused across all environments (dev, staging, production).
- To destroy all resources, simply comment out the main.tf file in the desired environment directory and push the changes to the corresponding branch.
- Use Python scripts to particular use cases, like one to delete all container images from an AWS ECR repository using boto3, before Terraform destroys the repository to avoid errors caused by existing images.


## Feel free to contribute or raise issues in this repository!
## This project is dedicated to learning, and your feedback and contributions are highly appreciated!

