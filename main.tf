module "eks-vpc" {
  source      = "./vpc"
  cidr-vpc    = "10.0.0.0/16"
  name-vpc    = "vpc-eks"
  subnet-cidr = var.subnets-cidr
  az-subnet   = var.subnets-az
}
module "eks" {
  source    = "./eks"
  subnet-id = [module.eks-vpc.subnet-id-0, module.eks-vpc.subnet-id-1]
  vpc-id = module.eks-vpc.vpc_id

}

module "networking" {
  source  = "./networking"
  vpc-id  = module.eks-vpc.vpc_id
  subnets = [module.eks-vpc.subnet-id-0, module.eks-vpc.subnet-id-1]
}

module "ec2" {
  source        = "./ec2"
  vpc-id        = module.eks-vpc.vpc_id
  ec2-ami       = var.ec2-ami
  instance_type = "t2.micro"
  script        = "install-dependencies.sh"
  subnet-id     = module.eks-vpc.subnet-id-1
  sorce         = "./k8s"
}

