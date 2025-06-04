# Configura o provedor Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
}

# Cria uma rede VPC para a VM
resource "google_compute_network" "vpc_network" {
  name = "${var.instance_name}-network"
}

# Cria uma regra de firewall para permitir SSH (porta 22) e a porta da aplicação
resource "google_compute_firewall" "ssh_and_app_access" {
  name    = "${var.instance_name}-firewall-ssh-app"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "${var.app_port}"]
  }

  source_ranges = ["0.0.0.0/0"] # Permite acesso de qualquer IP (em ambiente de produção, restrinja isso)
}

# Provisiona a máquina virtual
resource "google_compute_instance" "app_vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/${var.image_project}/global/images/family/${var.image_family}"
      size  = 30 # Tamanho do disco em GB
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }

  # Adiciona tags para a regra de firewall, se necessário (ex: "http-server")
  # tags = ["http-server"]
}

# Exporta o IP público da VM para uso posterior pelo Ansible
output "vm_external_ip" {
  value       = google_compute_instance.app_vm.network_interface[0].access_config[0].nat_ip
  description = "The external IP address of the VM."
}