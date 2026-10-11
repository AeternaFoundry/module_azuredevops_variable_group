resource "azuredevops_variable_group" "variable_groups" {
  for_each = var.variable_groups

  name         = each.value.name
  project_id   = each.value.project_id
  allow_access = each.value.allow_access
  description  = each.value.description

  dynamic "variable" {
    for_each = each.value.variable
    content {
      is_secret    = variable.value.is_secret
      name         = variable.value.name
      secret_value = variable.value.secret_value
      value        = variable.value.value
    }
  }

  dynamic "key_vault" {
    for_each = each.value.key_vault != null ? [each.value.key_vault] : []
    content {
      name                = key_vault.value.name
      search_depth        = key_vault.value.search_depth
      service_endpoint_id = key_vault.value.service_endpoint_id
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

