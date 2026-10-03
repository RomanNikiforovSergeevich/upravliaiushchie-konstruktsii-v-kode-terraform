variable "env_name" {
  type        = string
  description = "Имя окружения"
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "Список подсетей с зонами и CIDR"
}
