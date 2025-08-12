variable "ami_id" {
  type        = string
  description = "AMI ID to launch instance"
}

variable "instance_type" {
  type        = string
  default     = "t3a.medium"
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  default     = "subnet-0a7ff65d404bfbbfa"
  description = "apse1-az1 (ap-southeast-1a)"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "ec2_name_tagging" {
  type        = string
  description = "EC2 name for tagging"
}

variable "ebs_name_tagging" {
  type        = string
  description = "EBS name for tagging"
}

variable "private_ip" {
  type        = string
  description = "Private IP"
}

variable "user_data" {
  type = string
}
