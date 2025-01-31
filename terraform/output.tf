output "ipadd" {
  description = "Ip address of instance"
  value = google_compute_instance.cyderes.network_interface.0.access_config.0.nat_ip
  }
output "name" {
  description = "Name of instance"
  value = google_compute_instance.cyderes.name
}