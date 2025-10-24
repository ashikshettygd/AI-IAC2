resource "aws_security_group" "ec2_sg_20251024_060428" {
  name        = "ec2_sg_20251024_060428"
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg_20251024_060428"
  }
}

resource "aws_instance" "ec2_instance_20251024_060428" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.ec2_sg_20251024_060428.id
  ]
  key_name = aws_key_pair.my_key_20251024_060428.key_name

  tags = {
    Name = "ec2_instance_20251024_060428"
  }
}

resource "aws_key_pair" "my_key_20251024_060428" {
  key_name   = "my_key_20251024_060428"
  public_key = var.public_key
}
