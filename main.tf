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
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

metadata = {
    ssh-keys = "burnashowserega:${file("C:/Users/user/.ssh/id_rsa.pub")}"
}

provisioner "remote-exec" {
    inline = [
          "echo ${self.network_interface.0.access_config.0.nat_ip} >> ~/IP-address.txt"
      ]

    connection {
          type = "ssh"
          user = "burnashowserega"
          private_key = file("~/.ssh/id_rsa")
          host = self.network_interface.0.access_config.0.nat_ip
    }
}

}

resource "google_compute_firewall" "default" {
  name    = "hw-firewall"
  network = google_compute_network.vpc_network.name

  allow {
      protocol = "tcp"
      ports = ["22"]
  }

  allow {
      protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80-9090"]
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-network-23"
  auto_create_subnetworks = "true"
}

output "ip_addr" {
  value = "${google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip}"
}