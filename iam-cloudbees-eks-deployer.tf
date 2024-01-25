
resource "aws_iam_role" "cloudbees_eks_deployer" {
  name               = "cloudbees-eks-deployer"
  assume_role_policy = data.aws_iam_policy_document.assume_cloudbees_role.json
}

resource "aws_iam_role_policy_attachment" "cloudbees_eks_deployer" {
  role       = aws_iam_role.cloudbees_eks_deployer.id
  policy_arn = aws_iam_policy.cloudbees_eks_deployer.arn
}

resource "aws_iam_policy" "cloudbees_eks_deployer" {
  name   = "cloudbees-eks-deployer"
  policy = data.aws_iam_policy_document.cloudbees_eks_deployer.json
}

# Specifies what the role can actually do
data "aws_iam_policy_document" "cloudbees_eks_deployer" {
  version = "2012-10-17"
  statement {
    actions = [
      "eks:DescribeCluster",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
