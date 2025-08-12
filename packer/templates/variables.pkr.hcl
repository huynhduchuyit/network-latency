variable "project" {
  type        = string
  default     = "caladan"
  description = "Project name"
}

variable "region" {
  type        = string
  default     = "ap-southeast-1"
  description = "AWS region"
}

variable "source_ami" {
  type        = string
  default     = "ami-08e7e250e7e3deb9b"
  description = "Amazon EC2 AMI Locator (ap-southeast-1 / Noble Numbat / 24.04 LTS / amd64)"
}
