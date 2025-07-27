terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.44"
    }
  }

  # Remote state storage in GCS
  # Replace "your-gke-tf-state-bucket-name" with your actual, unique bucket name
#   backend "gcs" {
#     bucket = "your-gke-tf-state-bucket-name"
#     prefix = "terraform/state"
#   }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
