variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "iam_policy_name" {
  description = "IAM policy name for S3 access"
  type        = string
  default     = "S3AccessPolicy"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Name        = "terraform-s3-iam-project"
    Environment = "Dev"
  }
}