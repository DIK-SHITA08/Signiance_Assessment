#################################################
# Security Group Module
#################################################
module "security_group" {
  source      = "./modules/security_group"
  vpc_id      = var.vpc_id
  sg_name     = var.sg_name
  description = var.sg_description
  tags        = local.common_tags
}

#################################################
# Security Group Rules - Egress (All Outbound)
#################################################
module "security_group_rules_egress" {
  source            = "./modules/security_group_rules"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
  security_group_id = module.security_group.security_group_id
}

#################################################
# Security Group Rules - Ingress SSH (Port 22)
#################################################
module "security_group_rules_ssh" {
  source            = "./modules/security_group_rules"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow SSH access"
  security_group_id = module.security_group.security_group_id
}

#################################################
# Security Group Rules - Ingress HTTP (Port 80)
#################################################
module "security_group_rules_http" {
  source            = "./modules/security_group_rules"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTP access"
  security_group_id = module.security_group.security_group_id
}

#################################################
# Security Group Rules - Ingress HTTPS (Port 443)
#################################################
module "security_group_rules_https" {
  source            = "./modules/security_group_rules"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTPS access"
  security_group_id = module.security_group.security_group_id
}

#################################################
# EC2 Key Pair
#################################################
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

#################################################
# EC2 Instance Module
#################################################
module "ec2_instance" {
  source             = "./modules/ec2_instance"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = aws_key_pair.deployer.key_name
  subnet_id          = var.subnet_id
  vpc_id             = var.vpc_id
  region             = var.region
  security_group_ids = ["${module.security_group.security_group_id}"]
  tags               = merge(local.common_tags, { Name = "signiance-server" })
}
