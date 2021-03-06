locals {
  requirements = "${path.module}/roles/requirements.yaml"
  playbook     = "${path.module}/nomad.yaml"

  inventory = yamlencode({
    nomad_instances = {
      hosts = var.hosts
      vars  = var.vars
    }
  })
}

module "roles" {
  source = "../ansible-role-install"

  requirements = local.requirements
}

module "install" {
  source     = "../ansible-playbook"
  depends_on = [module.roles]

  namespace = var.namespace
  inventory = local.inventory
  playbook  = local.playbook
}
