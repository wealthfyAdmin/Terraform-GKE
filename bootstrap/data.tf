data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket = "my-terraform-bucket-sv"
    prefix = "gke/autopilot"
  }
}

data "google_client_config" "default" {}
