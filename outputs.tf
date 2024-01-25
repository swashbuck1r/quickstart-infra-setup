output "aws_user" {
  value = data.aws_iam_user.aws-user
}

output "remote_state_bucket" {
  value = aws_s3_bucket.tf_state.bucket
}


output "remote_state_dynamodb_table" {
  value = aws_dynamodb_table.tf_state_lock.name
}

