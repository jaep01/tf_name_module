locals {
  resource_name_prefix = {
    virtual_machine = "vm-"
    key_vault       = "kv-"
    storage_account = "sa"
  }
  resource_name_suffix = {
    virtual_machine = "-00"
    key_vault       = ""
    storage_account = ""
  }
}

locals {
  resource_name_draft      = "${local.resource_name_prefix[var.resource_type_in]}${var.base_name_in}${local.resource_name_suffix[var.resource_type_in]}"
  resource_name_delta      = length(local.resource_name_draft) - length(var.base_name_in)
  # resource_name_max_length = var.resource_name_max_length_in # 15 # later place this in the formation module
  base_name_substr         = var.resource_name_max_length_in - local.resource_name_delta < length(var.base_name_in) ? substr(var.base_name_in, 0, var.resource_name_max_length_in - local.resource_name_delta) : var.base_name_in
  resource_name_substr     = join("", [local.resource_name_prefix[var.resource_type_in], local.base_name_substr, local.resource_name_suffix[var.resource_type_in]])
  resource_name_final      = var.resource_type_in == "key_vault" ? lower(local.resource_name_substr) : (var.resource_type_in == "storage_account" ? lower(replace(local.resource_name_substr, "-", "")) : local.resource_name_substr)
}