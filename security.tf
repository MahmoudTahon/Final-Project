# Generate a new SSH key pair
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create and download the key pair
resource "aws_key_pair" "main" {
  key_name   = "mykey"
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./mykey.pem && chmod 400 ./mykey.pem"
  }
}
