variable "aws_user_name" {
  description = "An AWS user in the AWS account"
  type        = string
}

variable "tf_state_bucket_name" {
  description = "Bucket name to create for storing tf backend state"
  type        = string
  default     = "cloudbees-infra-tf-state"
}

variable "tf_state_dynamodb_table_name" {
  description = "DynamoDB table name used for tf backend state locking"
  type        = string
  default     = "cloudbees-infra-tf-state-lock"
}
