terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

provider "google" {
  project     = var.project_id
  region      = var.region
}

resource "google_cloud_run_service" "hello_world" {
  name     = "hello-world"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "noauth" {
  location    = google_cloud_run_service.hello_world.location
  project     = google_cloud_run_service.hello_world.project
  service     = google_cloud_run_service.hello_world.name
  role        = "roles/run.invoker"
  member      = "allUsers"
}

resource "google_service_account" "cloud_run_invoker" {
  account_id   = "cloud-run-invoker"
  display_name = "Cloud Run Invoker"
}

resource "google_project_iam_binding" "run_invoker_binding" {
  project = var.project_id
  role    = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.cloud_run_invoker.email}",
  ]
}

output "cloud_run_url" {
  value = google_cloud_run_service.hello_world.status[0].url
}
