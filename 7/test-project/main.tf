resource "yandex_vpc_network" "test" {
  name = "task7-test-network"
}

output "network_id" {
  value = yandex_vpc_network.test.id
}
