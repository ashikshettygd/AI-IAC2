output "ec2_instance_id" {
  value = aws_instance.ec2_20251024_012915.id
}

output "ec2_instance_public_ip" {
  value = aws_instance.ec2_20251024_012915.public_ip
}
