
resource "aws_iam_role" "cloudbees_ecr_publisher" {
  name               = "cloudbees-ecr-publisher"
  assume_role_policy = data.aws_iam_policy_document.assume_cloudbees_role.json
}

resource "aws_iam_role_policy_attachment" "cloudbees_ecr_publisher" {
  role       = aws_iam_role.cloudbees_ecr_publisher.id
  policy_arn = aws_iam_policy.cloudbees_ecr_publisher.arn
}

resource "aws_iam_policy" "cloudbees_ecr_publisher" {
  name   = "cloudbees-ecr-publisher"
  policy = data.aws_iam_policy_document.cloudbees_ecr_publisher.json
}

# Specifies what the role can actually do
data "aws_iam_policy_document" "cloudbees_ecr_publisher" {
  version = "2012-10-17"
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
