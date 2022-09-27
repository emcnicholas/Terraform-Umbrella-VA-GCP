# Provider
provider "google" {
  project = var.gcp-project-name
  region  = var.gcp-region
  zone    = var.gcp-zone
}

# Create Network
resource "google_compute_network" "vpc_network" {
  name                    = "gcp-network"
  auto_create_subnetworks = "true"
}

# Fetch the Umbrella Virtual
# Appliance Template from GCP Project
data "google_compute_instance_template" "umb_va_temp" {
  project = var.gcp-project-name
  name    = "umbrella-va-instance-template"
}

# Create Instance A via the template and connect it to the Network
resource "google_compute_instance_from_template" "umb_va_a" {
  name = "umb-va-a"
  zone = var.gcp-zone

  source_instance_template = data.google_compute_instance_template.umb_va_temp.id

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

# Create Instance B via the template and connect it to the Network
resource "google_compute_instance_from_template" "umb_va_b" {
  name = "umb-va-b"
  zone = var.gcp-zone

  source_instance_template = data.google_compute_instance_template.umb_va_temp.id

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}