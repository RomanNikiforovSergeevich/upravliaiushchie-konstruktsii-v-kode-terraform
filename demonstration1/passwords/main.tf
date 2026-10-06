terraform {
  required_providers {
      random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    }
  required_version = ">1.12.0"
}



resource "random_password" "input_vms" {
  for_each=toset(local.vms)
  length = 16
}
