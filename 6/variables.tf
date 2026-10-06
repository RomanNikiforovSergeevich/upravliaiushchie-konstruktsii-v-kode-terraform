### Cloud vars
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  description = "Зона доступности по умолчанию"
  default     = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  description = "CIDR-блоки подсети"
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  description = "Имя VPC сети и подсети"
  default     = "develop"
}

### Задание 4: валидация IP-адресов
variable "ip_address" {
  type        = string
  description = "ip-адрес"
  default     = "192.168.0.1"

  validation {
    condition     = can(cidrhost("${var.ip_address}/32", 0))
    error_message = "Значение переменной ip_address должно быть корректным IPv4-адресом."
  }
}

variable "ip_list" {
  type        = list(string)
  description = "список ip-адресов"
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]

  validation {
    condition = alltrue([
      for ip in var.ip_list : can(cidrhost("${ip}/32", 0))
    ])
    error_message = "Все элементы списка ip_list должны быть корректными IPv4-адресами."
  }
}

### Задание 5*: валидация строки
variable "any_string" {
  type        = string
  description = "любая строка"
  default     = "hello world"

  validation {
    condition     = var.any_string == lower(var.any_string)
    error_message = "Строка не должна содержать символов верхнего регистра."
  }
}

### Задание 5*: валидация объекта
variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition     = var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor
  }
}
