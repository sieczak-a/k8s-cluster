resource "google_service_account" "gke_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
}

resource "google_project_iam_member" "gke_sa_roles" {
  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_container_cluster" "default" {
  name                  = "${var.cluster_name}-${var.env}"
  location              = var.region
  initial_node_count    = var.initial_node_count
  deletion_protection   = false

  project = var.project_id

  resource_labels = {
    env = var.env
  }

  # Use dedicated service account
  node_config {
    service_account = google_service_account.gke_sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    # Use Spot VMs for cost optimization
    spot         = var.spot_nodes_enabled
    machine_type = var.machine_type
    disk_size_gb = 50
    disk_type    = "pd-standard"
  }

  # Secure cluster endpoint
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0" # Replace with your IP or an empty list
      display_name = "Allow all for now"
    }
  }

  # Use dedicated VPC
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.gke_subnet.name
}
