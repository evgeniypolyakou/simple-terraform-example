output "instance_id_bastion" {
  value       = module.ec2_instance_bastion.id
}

output "instance_id_admin" {
  value       = module.ec2_instance_admin.id
}


output "public_ip_bastion_host" {
  value = module.ec2_instance_bastion.public_ip
}

output "private_ip_bastion_host" {
  value = module.ec2_instance_bastion.private_ip
}

output "public_ip_admin_host" {
  value = module.ec2_instance_admin.public_ip
}

output "private_ip_admin_host" {
  value = module.ec2_instance_admin.private_ip
}