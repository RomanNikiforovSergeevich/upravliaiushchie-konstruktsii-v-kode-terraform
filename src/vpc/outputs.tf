output "network_id" {
  value       = yandex_vpc_network.this.id
  description = "ID созданной сети"
}

output "subnet_ids" {
  value       = [for s in yandex_vpc_subnet.this : s.id]
  description = "Список ID всех подсетей"
}

output "subnet_zones" {
  value       = [for s in yandex_vpc_subnet.this : s.zone]
  description = "Список зон всех подсетей"
}

output "subnets" {
  value = {
    for k, s in yandex_vpc_subnet.this : k => {
      id   = s.id
      zone = s.zone
      cidr = s.v4_cidr_blocks[0]
    }
  }
  description = "Map подсетей: ключ — зона, значение — id, zone, cidr"
}
