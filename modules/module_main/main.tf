resource "aws_instance" "module_ec2_20251024_012915" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.module_ec2_sg_20251024_012915.id]
  key_name               = var.key_name
}

resource "aws_security_group" "module_ec2_sg_20251024_012915" {
  name        = "module_ec2_sg_20251024_012915"
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
