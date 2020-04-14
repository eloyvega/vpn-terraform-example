variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Region to deploy the VPC and VPN"
}

variable "ami" {
  type        = string
  default     = "ami-0d6621c01e8c2de2c"
  description = "Amazon Linux 2 AMI"
}

variable "instance_type" {
  type        = string
  default     = "t2.small"
  description = "Type of EC2 instance"
}

variable "key_name" {
  type        = string
  description = "The key that will be attached to the instance. Create it first using EC2 console"
}