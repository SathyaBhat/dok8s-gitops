data "digitalocean_kubernetes_cluster" "dok8s" {
  name       = "dok8s"
  depends_on = [digitalocean_kubernetes_cluster.dok8s]
}

output "cluster_host" {
  value = data.digitalocean_kubernetes_cluster.dok8s.endpoint
}

output "cluster_token" {
  value     = data.digitalocean_kubernetes_cluster.dok8s.kube_config[0].token
  sensitive = true
}

output "cluster_ca_certificate" {
  value = base64decode(
    data.digitalocean_kubernetes_cluster.dok8s.kube_config[0].cluster_ca_certificate
  )
  sensitive = true
}