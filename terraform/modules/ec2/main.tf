resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  private_ip             = var.private_ip
  user_data              = var.user_data

  root_block_device {
    encrypted   = true
    volume_size = 30
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125

    tags = {
      Name = var.ebs_name_tagging
    }
  }

  tags = {
    Name = var.ec2_name_tagging
  }
}
