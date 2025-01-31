terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.18.1"
    }
  }
  backend "gcs" {
    bucket  = "cyderes-bucket-terraform-backened"
    prefix  = "terraform/state"
  }
}

provider "google" {
  credentials = file("service_account.json")
  project     = "methodical-mesh-415801"

}
resource "google_compute_instance" "cyderes" {
  boot_disk {
    auto_delete = true
    device_name = "Cyderes-instance"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240307b"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-micro"



  name = "cyderes-instance-by-oluwatobi-badejo"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/methodical-mesh-415801/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "251017531713-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server"]
  zone = "us-central1-a"
}
