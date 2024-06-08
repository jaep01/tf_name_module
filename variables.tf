variable "base_name_in" {
  description = "Base name of a resource"
}

variable "resource_type_in" {
  description = "Resource type to create. virtual_machine, key_vault, or storage_account are valid. Any other values will generate an error."
  validation {
    condition     = contains(["virtual_machine", "key_vault", "storage_account"], var.resource_type_in)
    error_message = "Valid values are virtual_machine, key_vault, or storage_account."
  }
}

variable "resource_name_max_length_in" {
  type        = number
  description = "Maximum number of characters allowed in the resource name"
}