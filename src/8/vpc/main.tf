terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100.0"
    }
  }
  required_version = ">1.12.0"

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = pathexpand("~/.authorized_key.json")
}

resource "yandex_vpc_network" "this" {
  name = "develop-network"
}

resource "yandex_vpc_subnet" "this" {
  name           = "develop-subnet-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}
