// ...existing code...
  module "vpc" {
    source = "../../modules/vpc"
  
    vpc_name            = var.vpc_name
    vpc_cidr            = var.vpc_cidr
    public_subnet_cidr  = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    a_z   = var.a_z

  }

module "ec2" {
  source = "../../modules/ec2"
  ami             = var.ami
  instance_type   = var.instance_type
  public_subnet   = module.vpc.public_id
  private_subnet  = module.vpc.private_id
  sg              = module.vpc.sg_id
  ec2_app_name    = module.vpc.vpc_name
  key             = var.key
}
