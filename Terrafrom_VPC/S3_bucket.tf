
# Creating a resource to generate a random UUID for the bucket name
resource "random_uuid" "bucket_name" {}

# Creating a private S3 bucket  with the random UUID generated
resource "aws_s3_bucket" "private_bucket" {
  bucket = random_uuid.bucket_name.result
  # Ensures Terraform can delete the bucket even if not empty
  force_destroy = true

  tags = {
    Name        = "CSYE6225_TerraformS3Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.private_bucket.id

  # Blocks new public ACLs from being added
  block_public_acls = true
  # Prevents the bucket from having a public policy
  block_public_policy = true
  # Ignores any existing public ACLs
  ignore_public_acls = true
  # Blocks all public access, even if ACLs and policies are misconfigured
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_policy" {
  bucket = aws_s3_bucket.private_bucket.id

  #   Rule for moving objects to IA storage class after 30 days
  rule {
    id     = "move-to-IA"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

# Displays the bucket name as an output
output "s3_bucket_name" {
  value = aws_s3_bucket.private_bucket.id
}
