terraform {
  backend "gcs" {
    bucket = "my-terraform-bucket-sv"
    prefix = "gke/autopilot"
  }
}