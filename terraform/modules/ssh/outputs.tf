output "key_name" {
  value = aws_key_pair.keypair.key_name
}

output "private_key_path" {
  value = local_file.private_key_file.filename
}
