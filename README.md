# DigitalOcean Kubernetes Community Challenge

This repo holds the infrastructure-as-code components for DigitalOcean's Kubernetes Challenge.

The Kubernetes Challenge is an event to pick up a challenge from the list provided by DigitalOcean and complete them. The challenge involves creating, configuring and deploying apps to a DigitalOcean Managed Kubernetes cluster. 

For the challenge, I picked up the "Deploy a GitOps CI/CD implementation" task. The description:

> GitOps is today the way you automate deployment pipelines within Kubernetes itself, and ArgoCD  is currently one of the leading implementations. Install it to create a CI/CD solution, using tekton and kaniko for actual image building

Things to do:

- [x] Create DigitalOcean Managed Kubernetes cluster(DOk8s) using Terraform
- [ ] Deploy ArgoCD to handle continuous delivery
