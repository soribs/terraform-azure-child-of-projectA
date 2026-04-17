module "resource_group" {
  source = "git@github.com:soribs/terraform-azure-child-of-projectA.git"

  resource_group_name = var.resource_group_name
  project_name        = var.project_name
}