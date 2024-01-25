# Sets up AWS resources for story TF state in an S3 backend
# https://developer.hashicorp.com/terraform/language/settings/backends/s3


# leverage an existing service account user to assume created roles
data "aws_iam_user" "aws-user" {
  user_name = var.aws_user_name
}


resource "aws_s3_bucket" "tf_state" {
  bucket        = var.tf_state_bucket_name
  force_destroy = true
}


resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tf_state_lock" {
  name         = var.tf_state_dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


# Entities that can assume these roles under specified conditions.
data "aws_iam_policy_document" "assume_cloudbees_role" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession", # without this you need to run actions with `role-skip-session-tagging: true`
    ]

    # Specifies the principals that can assume the role
    principals {
      identifiers = [
        data.aws_iam_user.aws-user.arn
      ]
      type = "AWS"
    }
  }
}
