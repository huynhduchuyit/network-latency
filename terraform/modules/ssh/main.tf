resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "keypair" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key_file" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.module}/${var.private_key_path}"
  file_permission = 600
}
