module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.19.1"

  cluster_name    = local.cluster_name
  cluster_version = "1.32"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Enable secrets encryption using your custom KMS key
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = aws_kms_key.jenkins_key.arn
  }

  create_kms_key = false

  # Explicitly set IAM policy prefix to avoid dynamic evaluation
  iam_role_policy_prefix = "arn:aws:iam::aws:policy"

  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2

      iam_role_attach_cni_policy = false

      iam_role_additional_policies = {
        eks_worker   = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        ecr_readonly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        eks_cni      = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
    }
  }

  depends_on = [aws_kms_key.jenkins_key]
}
