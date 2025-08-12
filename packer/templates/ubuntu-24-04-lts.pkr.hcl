source "amazon-ebs" "ubuntu-24-04-lts" {
  region        = var.region
  source_ami    = var.source_ami
  instance_type = "t3a.medium"
  ssh_username  = "ubuntu"
  ami_name      = "${var.project}-{{timestamp}}"

  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu-24-04-lts"]

  # Install Docker
  provisioner "shell" {
    script = "../scripts/install-docker.sh"
  }

  # Copy source code
  provisioner "file" {
    source      = "../../app"
    destination = "/home/ubuntu/app"
  }
}
