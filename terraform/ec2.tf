module "ec2_first" {
  source                 = "./modules/ec2"
  ami_id                 = var.ami_id_first_server
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.shared.id, aws_security_group.first-server.id]
  ec2_name_tagging       = "ec2-${var.project}-first"
  ebs_name_tagging       = "ebs-${var.project}-first"
  subnet_id              = var.subnet_id
  private_ip             = var.private_ip_first_server
  user_data              = file("setup.sh")

  depends_on = [
    aws_security_group.shared,
    aws_security_group.first-server
  ]
}

module "ec2_second" {
  source                 = "./modules/ec2"
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.shared.id]
  ec2_name_tagging       = "ec2-${var.project}-second"
  ebs_name_tagging       = "ebs-${var.project}-second"
  subnet_id              = var.subnet_id
  private_ip             = var.private_ip_second_server
  user_data              = ""

  depends_on = [
    aws_security_group.shared
  ]
}
