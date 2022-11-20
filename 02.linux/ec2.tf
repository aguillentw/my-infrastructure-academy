resource "aws_security_group" "abel-linux-sg" {
  name        = "abel-sg"
  description = "Allow incoming traffic to the Linux EC2 Instance"
  vpc_id      = aws_vpc.abel_linux_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "abel-linux-sg"
  }
}

# EC2 Instance
resource "aws_instance" "abel_linux" {
  ami                         = data.aws_ami.debian-11.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.abel_private_subnet_1a.id
  vpc_security_group_ids      = [aws_security_group.abel-linux-sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.abel_key_pair.key_name
  user_data                   = file("aws-user-data.sh")

  # root disk
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }

  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "10"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_size           = "10"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/xvdc"
    volume_size           = "10"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "abel-linux"
  }
}