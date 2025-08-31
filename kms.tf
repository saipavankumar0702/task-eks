resource "aws_kms_key" "jenkins_key" {
  description             = "KMS key for Jenkins and EKS"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-consolepolicy-full"
    Statement = [
      {
        Sid    = "EnableRootFullAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::020895663109:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowJenkinsFullAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::020895663109:user/jenkins"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowEKSClusterRoleFullAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::020895663109:role/eksClusterGuardian"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

output "jenkins_kms_key_arn" {
  value = aws_kms_key.jenkins_key.arn
}
