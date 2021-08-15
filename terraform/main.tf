
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name                 = "education-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
# add cloudwatch logs iam
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "security_groups_vpc" {
    source    = "../modules/security_groups"
    vpc_id    = module.vpc.vpc_id
    protocols = [
        {
        name : "worker_group_mgmt_one"
        cidr_blocks : ["10.0.0.0/8"]
        },
        {
        name : "worker_group_mgmt_two"
        cidr_blocks : ["192.168.0.0/16"]
        },
        {
        name : "all_worker_mgmt_group"
        cidr_blocks : [ "10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16",]
        }
    ]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  enable_irsa     = true

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }


  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [# spot fleet
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      asg_desired_capacity          = 0
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.large"
      asg_desired_capacity          = 2
    },
  ]
}
module "cloudwatch_logs" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-cloudwatch-logs.git"

  enabled = true

  cluster_name                     = local.cluster_name
  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  worker_iam_role_name             = module.eks.worker_iam_role_name
  region                           = var.region
}


resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "fleet.${data.aws_route53_zone.selected.name}."
  type    = "A"

  alias {
    name                   = data.aws_lb.main.dns_name
    zone_id                = data.aws_lb.main.zone_id
    evaluate_target_health = true
  }
}

module "alb" {
  source              = "terraform-aws-modules/alb/aws"
  version             = "6.4.0"
  name                = "interview-eks-nlb"
  subnets             = module.vpc.public_subnets
  vpc_id              = module.vpc.vpc_id
  load_balancer_type = "network"
}

module "container-insights" {
  source       = "Young-ook/eks/aws//modules/container-insights"
  cluster_name = local.cluster_name
  oidc         =  {
                  url = module.eks.cluster_oidc_issuer_url,
                  arn = module.eks.oidc_provider_arn
              }
  tags         = { env = "test" }
}
# module "route53-record" {
#   source  = "clouddrove/route53-record/aws"
#   version = "0.15.0"
#   zone_id = data.aws_route53_zone.selected.zone_id

#   # insert the 3 required variables here
# }