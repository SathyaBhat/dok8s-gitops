terraform {
  backend "remote" {
    organization = "sathyasays"

    workspaces {
      name = "dok8s"
    }
  }
}