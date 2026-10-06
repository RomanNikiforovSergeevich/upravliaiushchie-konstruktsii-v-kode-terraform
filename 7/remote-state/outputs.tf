output "bucket_name" {
  description = "Имя созданного S3-бакета"
  value       = yandex_storage_bucket.tfstate.bucket
}

output "access_key" {
  description = "Access Key ID"
  value       = yandex_iam_service_account_static_access_key.tfstate_key.access_key
  sensitive   = true
}

output "secret_key" {
  description = "Secret Key"
  value       = yandex_iam_service_account_static_access_key.tfstate_key.secret_key
  sensitive   = true
}

output "backend_config_example" {
  description = "Пример backend-конфигурации для основного проекта"
  value = <<-EOT
  terraform {
    backend "s3" {
      bucket  = "${yandex_storage_bucket.tfstate.bucket}"
      key     = "terraform.tfstate"
      region  = "ru-central1"
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
  EOT
}
