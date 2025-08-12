variable "key_name" {
  type        = string
  description = "Name of the AWS key pair"
}

variable "rsa_bits" {
  type        = number
  default     = 4096
  description = "RSA key size"
}

variable "private_key_path" {
  type        = string
  description = "Path to save private key file"
}
