resource "aws_instance" "ec2_20251024_012915" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg_20251024_012915.id]
  key_name               = "ec2_key_20251024_012915"
}

resource "aws_security_group" "ec2_sg_20251024_012915" {
  name        = "ec2_sg_20251024_012915"
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
}

resource "aws_key_pair" "ec2_key_20251024_012915" {
  key_name   = "ec2_key_20251024_012915"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+..."
}
