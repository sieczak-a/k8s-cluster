resource "google_container_cluster" "default" {
  name                = "gke-standard-dev-waw"
  location            = "europe-central2-a"
  initial_node_count  = 2
  deletion_protection = false

  project = "pro-hour-466407-c9"

  resource_labels = {
    env = "dev"
  }

  node_config {
    disk_type    = "pd-standard"
    disk_size_gb = 50
    machine_type = "e2-medium"
  }
}
