data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Demo VPN"
  cidr = "10.0.0.0/16"

  azs              = data.aws_availability_zones.azs.names[*]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = false
}

#--------------------------------------------------------------
# Security Group for Pritunl access
#--------------------------------------------------------------
resource "aws_security_group" "pritunl_access" {
  name        = "vpn-demo-pritunl"
  description = "Security Group to access Pritunl console"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "allow_ssh_traffic" {
  type              = "ingress"
  security_group_id = aws_security_group.pritunl_access.id

  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http_traffic" {
  type              = "ingress"
  security_group_id = aws_security_group.pritunl_access.id

  from_port   = "80"
  to_port     = "80"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https_traffic" {
  type              = "ingress"
  security_group_id = aws_security_group.pritunl_access.id

  from_port   = "443"
  to_port     = "443"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_outbound_traffic_pritunl" {
  type              = "egress"
  security_group_id = aws_security_group.pritunl_access.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}