terraform {
  cloud {
    organization = "sathyasays"

    workspaces {
      name = "dok8s-apps"
    }
  }
}