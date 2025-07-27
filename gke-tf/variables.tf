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

variable "machine_type" {
  description = "The machine type for GKE nodes."
  type        = string
  default     = "e2-medium"
}

variable "initial_node_count" {
  description = "The initial number of nodes for the GKE cluster."
  type        = number
  default     = 1
}

variable "spot_nodes_enabled" {
  description = "Whether to use cost-effective Spot VMs for the node pool."
  type        = bool
  default     = true
}
