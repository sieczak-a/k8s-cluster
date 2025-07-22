resource "google_container_cluster" "default" {
  name               = "gke-standard-regional-labels"
  location           = "europe-central2"
  initial_node_count = 2

  project = "pro-hour-466407-c9"

  resource_labels = {
    foo = "bar"
  }

  node_config {
    disk_type    = "pd-standard" # <- zamiast domyślnego pd-ssd
    disk_size_gb = 50
    machine_type = "e2-medium"
  }
}
