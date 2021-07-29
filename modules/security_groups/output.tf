output "security_group_names" {
  description = "Generated security_group_ids"
  #loop for every security_group that has been created and return a dict from thier name and ids
  value       = {for security_group in aws_security_group.security_group : security_group.name => security_group.id}
}