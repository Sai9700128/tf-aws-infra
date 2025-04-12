# CI/CD Pipeline with AWS Networking Infrastructure

This project combines a CI/CD pipeline for web application deployment with automated AWS networking infrastructure setup using Terraform.

## Table of Contents

- CI/CD Workflow
- CI/CD Workflow
- AWS Environment Setup
  - KMS Keys
  - SSL Certificate Configuration
- AWS Networking Setup
  - Prerequisites
  - Getting Started
  - Setup Instructions

- Additional Notes

## Prerequisites

Before proceeding, ensure the following tools are installed and configured:

1.⁠ ⁠AWS CLI:

- Install and set up the AWS CLI by following the [official instructions](https://aws.amazon.com/cli/).
- Run the command below to setup profile:
     ⁠ bash
     aws configure --profile <profile-name>
      ⁠
- Provide your AWS Access Key, Secret Access Key, region, and output format.

2.⁠ ⁠Terraform:

- Install Terraform by following the [official instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

---

## CI/CD Workflow

The CI/CD pipeline is triggered when a pull request is merged to the main branch. The workflow:

1. Runs unit tests
2. Validates the Packer template
3. Builds application artifacts
4. Builds an AMI in the DEV AWS account and shares it with the DEMO account
5. Updates the Launch Template in the DEMO account with the new AMI
6. Performs an instance refresh in the DEMO account's Auto Scaling Group

## AWS Environment Setup

AWS KMS Keys
The infrastructure uses AWS KMS keys for encryption with 90-day rotation period for:
- EC2 instances
- RDS databases
- S3 buckets
- Secrets Manager (database passwords and email service credentials)

## SSL Certificate Configuration

### Dev Environment

For the dev environment, AWS Certificate Manager (ACM) is used to generate SSL certificates automatically.

### Demo Environment

For the demo environment, you need to manually request an SSL certificate from a third-party vendor (e.g., Namecheap) and import it into AWS Certificate Manager.

### Steps to Import SSL Certificate into AWS

``` Purchase an SSL certificate from Namecheap or another SSL vendor. ```
Download the certificate files:

```Certificate file (certificate.crt)```
```Private key file (private.key)```
```Certificate chain file (ca_bundle.crt)```

Import the certificate into AWS Certificate Manager using the AWS CLI:

```
bashaws acm import-certificate \
  --certificate fileb://certificate.crt \
  --private-key fileb://private.key \
  --certificate-chain fileb://ca_bundle.crt \
  --region us-east-1
```

# AWS Networking Setup

This project automates the setup of networking infrastructure on Amazon Web Services (AWS) using Terraform. The configuration ensures the creation of a Virtual Private Cloud (VPC) and its associated subnets, adhering to best practices for scalable and flexible networking. This solution supports configuring multiple VPCs with custom settings within the same AWS account.

---

## Prerequisites

Before proceeding, ensure the following tools are installed and configured:

1.⁠ ⁠AWS CLI:

- Install and set up the AWS CLI by following the [official instructions](https://aws.amazon.com/cli/).
- Run the command below to setup profile:
     ⁠ bash
     aws configure --profile <profile-name>
      ⁠
- Provide your AWS Access Key, Secret Access Key, region, and output format.

2.⁠ ⁠Terraform:

- Install Terraform by following the [official instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

---

## Getting Started

Follow the steps below to set up the networking infrastructure using Terraform:

### 1. Configure AWS Credentials

- Ensure your AWS credentials are configured using the AWS CLI ( aws configure)

### 2. Update Variables

- Open the ⁠terraform.tfvars⁠ file and update necessary variables such as ⁠ num_vpcs ⁠, ⁠ region ⁠, and ⁠ cidr_blocks ⁠ according to your AWS environment.

---

## Instructions to Set Up the Networking Infrastructure

1.⁠ ⁠Clone the repository:
   ⁠ bash
   git clone <repository-url>
   cd <repository-directory>
    ⁠
2.⁠ ⁠Initialize Terraform:

    - Run the following command to initialize Terraform:
        ⁠ bash
        terraform init
         ⁠

2.⁠ ⁠Apply the configuration:

- Run the following command to apply the configuration:
     ⁠ bash
     terraform apply
      ⁠
- Review and confirm the proposed changes when prompted.

3.⁠ ⁠Destroy the configuration (if needed):

- If you need to destroy the created infrastructure, run the following command:
     ⁠ bash
     terraform destroy
      ⁠

---

## Notes

•⁠  ⁠Ensure you have appropriate permissions in your AWS account to create VPCs, subnets, and associated resources.
•⁠  ⁠Always review the Terraform plan before applying changes to avoid unintended modifications to your infrastructure.

---
