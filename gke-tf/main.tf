resource "google_service_account" "gke_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
}

resource "google_project_iam_member" "gke_sa_roles" {
  for_each = toset([
    "roles/container.nodeServiceAccount",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/logging.logWriter"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_container_cluster" "default" {
  name                     = "${var.cluster_name}-${var.env}"
  location                 = var.region
  deletion_protection      = false
  remove_default_node_pool = true
  initial_node_count       = 1

  project = var.project_id

  resource_labels = {
    env = var.env
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "02:00"
    }
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

resource "google_container_node_pool" "gke_dev_pool" {
  name     = "gke-dev"
  project  = var.project_id
  location = var.region
  cluster  = google_container_cluster.default.name

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = "e2-standard-2"
    disk_size_gb = 50
    disk_type    = "pd-standard"
    spot         = false

    service_account = google_service_account.gke_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
