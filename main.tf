module "vpc" {
  source                  = "./vpc"
  vpc_cidr                = "10.0.0.0/20"
  subnet_1_cidr           = "10.0.1.0/24"
  subnet_2_cidr           = "10.0.2.0/24"
  availability_zone_1     = "ap-southeast-2a"
  availability_zone_2     = "ap-southeast-2b"
  map_public_ip_on_launch = false
  route_cidr              = "0.0.0.0/0"
}

# module "instance" {
#   source        = "./instance"
#   ami           = "ami-003f5a76758516d1e"
#   instance_type = "t2.micro"
#   subnet_id     = module.vpc.subnet_new_id_1

# }

module "security_group" {
    source = "./security_group"
    cidr_sec_block = "0.0.0.0/0"
    sec_vpc_id = module.vpc.vpc_id
}