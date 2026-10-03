terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5.9"
    }
  }
  required_version = ">1.12.0"
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
}

data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

resource "vault_generic_secret" "new_secret" {
  path = "secret/new_example"
  data_json = jsonencode({
    username = "admin"
    password = "s3cr3t"
  })
}
