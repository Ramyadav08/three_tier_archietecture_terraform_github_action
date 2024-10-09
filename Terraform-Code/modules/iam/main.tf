resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_ssm_distantcore"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "ec2_s3_ssm_distantcore"
  }
}

# S3 Read-Only Access Policy
resource "aws_iam_policy" "s3_read_policy" {
  name = "S3ReadAccess"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

# SSM Management and DistantCore Policy
resource "aws_iam_policy" "ssm_management_policy" {
  name = "SSMManagementAndDistantCoreAccess"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:DescribeInstanceInformation",
          "ssm:GetCommandInvocation",
          "ssm:ListCommands",
          "ssm:SendCommand",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:PutParameter",
          "ssm:StartSession",
          "ssm:DescribeSessions",
          "ssm:TerminateSession",
          "ssm:ResumeSession",
          "ec2messages:GetMessages",
          "ec2messages:AcknowledgeMessage",
          "ec2messages:SendReply",
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach the policies to the IAM role
resource "aws_iam_role_policy_attachment" "s3_read_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_management_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ssm_management_policy.arn
}
