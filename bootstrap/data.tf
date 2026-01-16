data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket = "solvox-terraform-state"
    prefix = "gke/autopilot"
  }
}

data "google_client_config" "default" {}
