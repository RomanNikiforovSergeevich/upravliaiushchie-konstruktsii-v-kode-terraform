resource "null_resource" "ansible_provision" {
  depends_on = [
    null_resource.ansible_inventory,
  ]

  triggers = {
    inventory_hash = sha256(local.ansible_inventory)
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/test.yml"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_FORKS             = "1"
    }
  }
}
