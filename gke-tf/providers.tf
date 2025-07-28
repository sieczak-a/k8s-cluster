terraform {
  required_version = ">= 1.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.44"
    }
  }

  # Remote state storage in GCS
  backend "gcs" {
    bucket = "gke-dev-tf-waw-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
