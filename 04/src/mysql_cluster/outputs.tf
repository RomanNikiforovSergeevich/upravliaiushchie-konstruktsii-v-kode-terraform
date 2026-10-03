output "cluster_id" {
  description = "ID созданного кластера MySQL"
  value       = yandex_mdb_mysql_cluster.this.id
}
