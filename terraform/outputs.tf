output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_instance.instance_public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instance.instance_id
}

output "ec2_private_ip" {
  value = module.ec2_instance.private_ip
}

output "security_group_id" {
  value = module.security_group.security_group_id
}
