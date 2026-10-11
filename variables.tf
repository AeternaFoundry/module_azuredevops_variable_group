variable "variable_groups" {
  description = <<EOT
Map of variable_groups, attributes below
Required:
    - name
    - project_id
    - variable (block):
        - is_secret (optional)
        - name (required)
        - secret_value (optional)
        - value (optional)
Optional:
    - allow_access
    - description
    - key_vault (block):
        - name (required)
        - search_depth (optional)
        - service_endpoint_id (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - read (optional)
        - update (optional)
EOT

  type = map(object({
    name         = string
    project_id   = string
    allow_access = optional(bool)
    description  = optional(string)
    variable = list(object({
      is_secret    = optional(bool)
      name         = string
      secret_value = optional(string)
      value        = optional(string)
    }))
    key_vault = optional(object({
      name                = string
      search_depth        = optional(number)
      service_endpoint_id = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.variable_groups : (
        length(v.variable) >= 1
      )
    ])
    error_message = "Each variable list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.variable_groups : (
        can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.project_id))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.variable_groups : (
        length(trimspace(v.name)) > 0
      )
    ])
    error_message = "must not be empty or only whitespace"
  }
  validation {
    condition = alltrue([
      for k, v in var.variable_groups : (
        v.key_vault == null || (length(trimspace(v.key_vault.name)) > 0)
      )
    ])
    error_message = "must not be empty or only whitespace"
  }
  validation {
    condition = alltrue([
      for k, v in var.variable_groups : (
        v.key_vault == null || (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.key_vault.service_endpoint_id)))
      )
    ])
    error_message = "must be a valid UUID"
  }
}

