locals {
  ansible_inventory = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = yandex_compute_instance.db
    storage    = [yandex_compute_instance.storage]
    bastion_ip = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
  })
}

resource "null_resource" "ansible_inventory" {
  depends_on = [
    yandex_compute_instance.bastion,
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage,
  ]

  triggers = {
    inventory = local.ansible_inventory
  }

  provisioner "local-exec" {
    command = "echo '${base64encode(self.triggers.inventory)}' | base64 -d > ${abspath(path.module)}/hosts.ini"
  }
}
