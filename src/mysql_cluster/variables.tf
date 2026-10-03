variable "cluster_name" {
  description = "Имя кластера MySQL"
  type        = string
}

variable "network_id" {
  description = "ID сети, в которой будет создан кластер"
  type        = string
}

variable "subnet_ids" {
  description = "Список ID подсетей для размещения хостов"
  type        = list(string)
}

variable "zones" {
  description = "Список зон доступности для размещения хостов"
  type        = list(string)
}

variable "ha" {
  description = "Флаг для создания кластера с высокой доступностью (2 хоста)"
  type        = bool
  default     = false
}
