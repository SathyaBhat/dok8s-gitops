resource "digitalocean_project" "dok8s" {
  name        = "DO K8s"
  description = "A project to hold resources used in the DigitalOcean Kubernetes."
}