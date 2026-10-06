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
  required_version = ">=1.12.0"
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

# Генерируем уникальный суффикс для имени бакета
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# 1. S3-бакет для tfstate с версионированием
resource "yandex_storage_bucket" "tfstate" {
  bucket    = "tfstate-task7-${random_string.suffix.result}"
  folder_id = var.folder_id
  force_destroy = true
  
  versioning {
    enabled = true
  }
}

# 2. Сервисный аккаунт
resource "yandex_iam_service_account" "tfstate_sa" {
  name        = "tfstate-task7-sa-${random_string.suffix.result}"
  description = "Service account for Terraform remote state (task 7)"
}

# 3. Роль storage.editor на бакет
resource "yandex_storage_bucket_iam_binding" "binding" {
  bucket = yandex_storage_bucket.tfstate.bucket
  role   = "storage.editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.tfstate_sa.id}"
  ]
}

# 4. Статический ключ доступа
resource "yandex_iam_service_account_static_access_key" "tfstate_key" {
  service_account_id = yandex_iam_service_account.tfstate_sa.id
  description        = "Static access key for Terraform remote state (task 7)"
}
