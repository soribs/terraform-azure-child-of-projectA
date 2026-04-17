resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location_name

  tags = local.common_tags
}