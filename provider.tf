
variable "path" {
  default     = "C:/terraform/hw"
}


provider "google" {
    project = "cryptic-gate-291715"
    region = "europe-west3"
    credentials = "${file("${var.path}/secrets.json")}"
}