# Create an S3 bucket to store Terraform state files
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-FS"

  # Prevent the bucket from being accidentally deleted
  lifecycle {
    prevent_destroy = false
  }
}

# Enable versioning for the S3 bucket created earlier
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create a DynamoDB table to manage locks for Terraform state
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Configure the Terraform backend to store state in S3 and use DynamoDB to manage locks
terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-state-haidy"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
