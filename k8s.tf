resource "digitalocean_kubernetes_cluster" "dok8s" {
    ha = false
    name = "dok8s"
    region = "ams3"
    version = "1.21.5-do.0"
    node_pool {
      auto_scale = true
      min_nodes = 1
      max_nodes = 5
      name = "k8s-workers"
      size = "s-2vcpu-4gb" #  from https://slugs.do-api.dev/ 
    }
}