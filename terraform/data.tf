data "aws_availability_zones" "available" {}
data "aws_eks_cluster" "cluster" {name = module.eks.cluster_id}
data "aws_eks_cluster_auth" "cluster" {name = module.eks.cluster_id}

data "aws_route53_zone" "selected" {
  private_zone = false
  zone_id          = "Z0334646115V1WD7WFUSR"

}

data "aws_lb" "main" {
  arn  = var.lb_arn
  name = var.lb_name
  depends_on = [
    module.eks,
  ]
  #requires nlb to exist
}
