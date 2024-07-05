data "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role" "ec2_ecr_role" {
  name = "EC2_ECR_ReadOnly_Role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "EC2_ECR_ReadOnly_Role"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_ecr_readonly_attachment" {
  role       = aws_iam_role.ec2_ecr_role.name
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_ecr_role.name
}