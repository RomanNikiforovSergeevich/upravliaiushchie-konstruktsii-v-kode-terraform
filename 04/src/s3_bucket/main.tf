terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">1.12.0"
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = pathexpand("~/.authorized_key.json")
  zone                     = "ru-central1-a"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "yandex_storage_bucket" "s3_bucket" {
  bucket = "netology-bucket-${random_string.suffix.result}"
}
