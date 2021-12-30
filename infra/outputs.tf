data "digitalocean_kubernetes_cluster" "dok8s" {
  name       = "dok8s"
  depends_on = [digitalocean_kubernetes_cluster.dok8s]
}

output "cluster_host" {
  value = data.digitalocean_kubernetes_cluster.dok8s.endpoint
}

output "cluster_name" {
  value = data.digitalocean_kubernetes_cluster.dok8s.name
}
