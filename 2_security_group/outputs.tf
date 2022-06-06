output "security_group_id_bastion" {
  description = "The ID of the security group"
  value       = module.security-group_bastion.security_group_id
}

output "security_group_id_admin" {
  description = "The ID of the security group"
  value       = module.security-group_admin.security_group_id
}