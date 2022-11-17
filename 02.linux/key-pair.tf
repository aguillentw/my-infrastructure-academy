# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "abel_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the Key Pair
resource "aws_key_pair" "abel_key_pair" {
  key_name   = "abel-key-pair"
  public_key = tls_private_key.abel_key_pair.public_key_openssh

  tags = {
    Name = "abel-key-pair"
  }
}

# Save file
resource "local_file" "abel_ssh_key" {
  filename = "${aws_key_pair.abel_key_pair.key_name}.pem"
  content  = tls_private_key.abel_key_pair.private_key_pem
  file_permission = "0400"
}