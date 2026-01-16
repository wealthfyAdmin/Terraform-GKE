variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GKE cluster region"
  type        = string
}

variable "cluster_name" {
  description = "Autopilot cluster name"
  type        = string
}

variable "maintenance_start_time" {
  description = "Maintenance start time in UTC"
  type        = string
}

variable "maintenance_end_time" {
  description = "Maintenance end time in UTC"
  type        = string
}
