variable "project_id" {
  description = "The Google Cloud project ID to deploy resources into."
  type        = string
}

variable "region" {
  description = "The Google Cloud region to deploy resources into."
  type        = string
  default     = "europe-central2"
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "gke-standard-dev"
}

variable "env" {
  description = "The environment tag for the resources."
  type        = string
  default     = "dev"
}
