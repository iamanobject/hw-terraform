resource "google_compute_instance" "default" {
    count = "${length(var.name_count)}"
    name = "hw-${count.index+1}"
    machine_type = var.machine_type
    zone = var.zone


boot_disk {
    initialize_params {
        image = var.image
    }
}

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
}
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-network-23"
  auto_create_subnetworks = "true"
}