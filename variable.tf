variable "image" { default = "ubuntu-os-cloud/ubuntu-minimal-1804-lts" }
variable "machine_type" { default = "e2-micro" }
variable "zone" { default = "europe-west3-a" }

variable "name_count" { default = ["server1", "server2"] }