locals {
  ssh_key = file("~/.ssh/ssh-key-1771586047288.pub")

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }
}
