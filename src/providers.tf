terraform {
  required_version = ">1.12.0"
  
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.100.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }

  backend "s3" {
    bucket  = "netology-bucket-urd6b0ph"
    key     = "terraform.tfstate"
    region  = "ru-central1"
    # Встроенный механизм блокировок (Terraform >= 1.6)
    use_lockfile = true
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }  
}

provider "yandex" {
  service_account_key_file = pathexpand("~/.authorized_key.json")
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
