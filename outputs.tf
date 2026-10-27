output "variable_groups_id" {
  description = "Map of id values across all variable_groups, keyed the same as var.variable_groups"
  value       = { for k, v in azuredevops_variable_group.variable_groups : k => v.id }
}
output "variable_groups_allow_access" {
  description = "Map of allow_access values across all variable_groups, keyed the same as var.variable_groups"
  value       = { for k, v in azuredevops_variable_group.variable_groups : k => v.allow_access }
}
output "variable_groups_description" {
  description = "Map of description values across all variable_groups, keyed the same as var.variable_groups"
  value       = { for k, v in azuredevops_variable_group.variable_groups : k => v.description }
}
output "variable_groups_key_vault" {
  description = "Map of key_vault values across all variable_groups, keyed the same as var.variable_groups"
  value       = { for k, v in azuredevops_variable_group.variable_groups : k => one(v.key_vault) }
}
output "variable_groups_name" {
  description = "Map of name values across all variable_groups, keyed the same as var.variable_groups"
  value       = { for k, v in azuredevops_variable_group.variable_groups : k => v.name }
}
output "variable_groups_project_id" {
  description = "Map of project_id values across all variable_groups, keyed the same as var.variable_groups"
  value       = { for k, v in azuredevops_variable_group.variable_groups : k => v.project_id }
}
output "variable_groups_variable" {
  description = "Map of variable values across all variable_groups, keyed the same as var.variable_groups"
  value       = { for k, v in azuredevops_variable_group.variable_groups : k => v.variable }
  sensitive   = true
}

