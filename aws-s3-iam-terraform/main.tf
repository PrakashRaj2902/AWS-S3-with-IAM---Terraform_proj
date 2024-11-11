# Create the S3 bucket
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Lifecycle policy: Archive objects older than 30 days to Glacier
  lifecycle_rule {
    id      = "archive-objects"
    enabled = true
    prefix  = "logs/"  # Example folder
    transitions {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  # Tags for the S3 bucket
  tags = var.tags
}

# IAM policy for S3 access
resource "aws_iam_policy" "s3_policy" {
  name        = var.iam_policy_name
  description = "Policy for accessing S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_s3_bucket.bucket}/*"
      },
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_s3_bucket.bucket}/*"
      }
    ]
  })
}

# IAM role to attach the policy
resource "aws_iam_role" "s3_role" {
  name = "S3AccessRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Effect   = "Allow"
    }]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# Output bucket name and IAM role ARN
output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.my_s3_bucket.bucket
}

output "iam_role_arn" {
  description = "ARN of the IAM role with the S3 policy attached"
  value       = aws_iam_role.s3_role.arn
}