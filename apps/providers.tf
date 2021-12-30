terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    helm = {
      source = "hashicorp/helm"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

data "tfe_outputs" "dok8s-infra" {
  organization = "sathyasays"
  workspace    = "dok8s-infra"
}

provider "digitalocean" {
  token = var.DO_TOKEN
}

data "digitalocean_kubernetes_cluster" "dok8s" {
  name = data.tfe_outputs.dok8s-infra.values.cluster_name
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.dok8s.endpoint
  token = data.digitalocean_kubernetes_cluster.dok8s.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.dok8s.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = data.digitalocean_kubernetes_cluster.dok8s.endpoint
    token = data.digitalocean_kubernetes_cluster.dok8s.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.dok8s.kube_config[0].cluster_ca_certificate
    )
  }
}


