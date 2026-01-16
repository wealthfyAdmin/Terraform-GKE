resource "google_container_cluster" "autopilot" {
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  # Default VPC (no extra cost)
  network    = "default"
  subnetwork = "default"

  deletion_protection = false

  maintenance_policy {
    recurring_window {
      start_time = var.maintenance_start_time
      end_time   = var.maintenance_end_time
      recurrence = "FREQ=DAILY"
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  # Required for VPC-native clusters (Autopilot enforces this)
  ip_allocation_policy {}
}
