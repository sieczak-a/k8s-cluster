# Kubernetes Cluster Configuration

This repository contains the configuration for a Kubernetes cluster running on Google Kubernetes Engine (GKE). It uses Terraform for infrastructure provisioning and ArgoCD for GitOps-based application deployment.

## Overview

The repository is structured as follows:

-   `gke-tf`: Contains Terraform files for provisioning the GKE cluster and related resources.
-   `argo-bootstrap`: Scripts for bootstrapping ArgoCD on the cluster.
-   `argocd`: Contains ArgoCD application definitions for deploying various services.
-   `gke-objects`: Kubernetes manifests for objects that are not managed by ArgoCD, such as Istio Gateways and Certificates.

### Infrastructure (gke-tf)

The `gke-tf` directory contains the Terraform configuration for the following resources:

-   A GKE cluster with a single node pool.
-   A dedicated VPC network and subnet for the cluster.
-   A service account for the GKE nodes with appropriate IAM roles.

### ArgoCD

ArgoCD is used to manage the deployment of applications to the cluster. The `argocd` directory contains the following:

-   `bootstrap-apps-of-apps.yaml`: An ArgoCD application that deploys all other applications.
-   `apps/`: A directory containing the ArgoCD application definitions for each service.

The following applications are deployed:

-   `cert-manager`: For managing TLS certificates.
-   `istio`: Service mesh for traffic management, security, and observability.
-   `keycloak`: Open-source identity and access management.
-   `vault`: For managing secrets.

### GKE Objects

The `gke-objects` directory contains Kubernetes manifests for the following:

-   Istio Gateways for exposing services to the internet.
-   Certificates for the exposed services.
-   Vault configuration for authentication and secret access.

## Getting Started

To get started with this repository, you will need to have the following installed:

-   Terraform
-   gcloud CLI
-   kubectl
-   helm

### Provisioning the Infrastructure

1.  Initialize Terraform:
    ```
    cd gke-tf
    terraform init
    ```
2.  Create a `terraform.tfvars` file with your project-specific values.
3.  Apply the Terraform configuration:
    ```
    terraform apply
    ```

### Bootstrapping ArgoCD

1.  Get the kubeconfig for your new cluster.
2.  Run the bootstrap script:
    ```
    ./argo-bootstrap/install.sh
    ```

### Deploying Applications

Once ArgoCD is bootstrapped, it will automatically deploy the applications defined in the `argocd/apps` directory. You can monitor the status of the applications in the ArgoCD UI.
