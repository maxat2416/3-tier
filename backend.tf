module "vpc" {
  source = "../../modules/vpc"

  # Pass any required input variables for the VPC module
}

module "bastion" {
  source = "../../modules/bastion"

  # Pass the VPC ID from the VPC module to the frontend module
  vpc_id = module.vpc.vpc_id
  public_1_subnet = module.vpc.public_subnet_az1_id
  
}

module "rds" { 
  source = "../../modules/rds"
  vpc_id = module.vpc.vpc_id
  private_app_subnet_az2  = module.vpc.private_app_subnet_az2_id
  private_app_subnet_az1  = module.vpc.private_app_subnet_az1_id
  bastion_security_group  = module.bastion.bastion_security_group
  instance_class          = "db.t2.micro"
  password_db = "05101990Dm!" 
}

# module "frontend" {
#   source                  = "../../modules/frontend"
#   vpc_id                  = module.vpc.vpc_id
#   public_2_subnet         = module.vpc.public_subnet_az2_id
#   public_1_subnet         = module.vpc.public_subnet_az1_id
# }