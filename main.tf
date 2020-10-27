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
    network = "default"
}

service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
}

}