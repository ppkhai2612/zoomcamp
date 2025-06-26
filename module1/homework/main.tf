terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.29.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("../terraform_gcp/keys/credentials.json")
  project = "zoomcamp-463511"
  region  = "us-central1"
}

resource "google_storage_bucket" "demo_bucket" {
  name          = "terraform-zoomcamp-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = "demo_dataset"
  location = "US"
}