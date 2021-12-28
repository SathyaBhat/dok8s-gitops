terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    helm = {
      source = "hashicorp/helm"
    }
  }
}

data "terraform_remote_state" "dok8s-infra" {
  backend = "remote"

  config = {
    organization = "sathyasays"
    workspaces = {
      name = "dok8s-infra"
    }
  }
}

provider "kubernetes" {
  host = data.terraform_remote_state.dok8s-infra.cluster_host
  token = data.terraform_remote_state.dok8s-infra.cluster_token
  cluster_ca_certificate = data.terraform_remote_state.dok8s-infra.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host = data.terraform_remote_state.dok8s-infra.cluster_host
    token = data.terraform_remote_state.dok8s-infra.cluster_token
    cluster_ca_certificate = data.terraform_remote_state.dok8s-infra.cluster_ca_certificate
  }
}


