
resource "aws_iam_role" "cloudbees_infra_mgmt" {
  name               = "cloudbees-infra-mgmt"
  assume_role_policy = data.aws_iam_policy_document.assume_cloudbees_role.json
}

resource "aws_iam_role_policy_attachment" "cloudbees_infra_mgmt" {
  role       = aws_iam_role.cloudbees_infra_mgmt.id
  policy_arn = aws_iam_policy.cloudbees_infra_mgmt.arn
}

resource "aws_iam_policy" "cloudbees_infra_mgmt" {
  name   = "cloudbees-infra-mgmt"
  policy = data.aws_iam_policy_document.cloudbees_infra_mgmt.json
}

# Specifies what the cloudbees_infra_mgmt role can actually do
# This is permissive policy, so tune it back to the based on the infrastructure
# that you really want infra automations to be able to manage. 
data "aws_iam_policy_document" "cloudbees_infra_mgmt" {
  version = "2012-10-17"
  statement {
    actions = [
      "lambda:*",
      "apigateway:*",
      "ec2:*",
      "rds:*",
      "s3:*",
      "sns:*",
      "states:*",
      "ssm:*",
      "sqs:*",
      "iam:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "cloudfront:*",
      "route53:*",
      "ecr:*",
      "logs:*",
      "ecs:*",
      "eks:*",
      "ecr:*",
      "application-autoscaling:*",
      "logs:*",
      "events:*",
      "elasticache:*",
      "es:*",
      "kms:*",
      "dynamodb:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
