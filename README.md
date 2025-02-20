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