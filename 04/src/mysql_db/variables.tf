variable "cluster_id" {
  description = "ID кластера MySQL, в котором создаётся БД и пользователь"
  type        = string
}

variable "database_name" {
  description = "Имя создаваемой базы данных"
  type        = string
}

variable "user_name" {
  description = "Имя создаваемого пользователя"
  type        = string
}

variable "user_password" {
  description = "Пароль для создаваемого пользователя"
  type        = string
  sensitive   = true
}
