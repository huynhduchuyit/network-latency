resource "aws_security_group" "shared" {
  name = "segr-${var.project}-shared"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow traffic between instances"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "segr-${var.project}-shared"
  }
}

resource "aws_security_group" "first-server" {
  name = "segr-${var.project}-first-server"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow traffic between instances"
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = var.whitelisted_ips
  }

  tags = {
    Name = "segr-${var.project}-first-server"
  }
}
