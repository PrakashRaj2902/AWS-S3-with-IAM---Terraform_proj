output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.my_s3_bucket.bucket
}

output "iam_role_arn" {
  description = "ARN of the IAM role with attached S3 policy"
  value       = aws_iam_role.s3_role.arn
}