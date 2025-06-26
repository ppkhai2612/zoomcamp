variable "credentials" {
  description = "My Credentials"
  default     = "../keys/credentials.json"
}

variable "project" {
  description = "Project"
  default     = "zoomcamp-463511"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "terraform-demo-456502_demo-bucket"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}
