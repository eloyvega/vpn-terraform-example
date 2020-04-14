resource "aws_instance" "vpn" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  source_dest_check      = false
  user_data              = file("${path.module}/user_data.sh")
  vpc_security_group_ids = [aws_security_group.pritunl_access.id]
  subnet_id              = module.vpc.public_subnets[0]
}

resource "aws_eip" "eip" {
  vpc = true

  instance                  = aws_instance.vpn.id
  associate_with_private_ip = aws_instance.vpn.private_ip
}

output "vpn_address" {
  value = aws_eip.eip.public_ip
}