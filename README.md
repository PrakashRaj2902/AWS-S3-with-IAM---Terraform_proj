**# AWS-S3-with-IAM---Terraform_proj**

This project demonstrates how to create an AWS S3 bucket with versioning, lifecycle rules, and IAM policies to manage access. The configuration includes setting up an S3 bucket, applying lifecycle rules to move objects to Glacier storage after a specified period, enabling versioning for objects, and attaching IAM policies for controlling access to the bucket.

## Project Overview

This Terraform project includes:
- Creation of an S3 bucket with versioning enabled.
- Lifecycle rules to transition objects to Glacier storage.
- An IAM policy to grant `GetObject` and `PutObject` access to the S3 bucket.
- IAM role to attach the policy and allow access.
