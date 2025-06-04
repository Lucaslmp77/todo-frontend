variable "project_id" {
  description = "fim-de-semestre"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "us-central1" # Foz do Iguaçu está no Brasil, então esta região é uma boa escolha
}

variable "zone" {
  description = "The GCP zone to deploy the VM"
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "The machine type for the VM (e.g., e2-medium, e2-small)"
  type        = string
  default     = "e2-micro" # 2 vCPU, 2GB RAM
}

variable "image_project" {
  description = "The project of the OS image"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "image_family" {
  description = "The family of the OS image (e.g., ubuntu-2204-lts)"
  type        = string
  default     = "ubuntu-2204-lts" # Ubuntu Server
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "my-app-vm"
}

variable "ssh_user" {
  description = "The username for SSH access to the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "Your SSH public key content"
  type        = string
}

variable "app_port" {
  description = "The port your application will run on"
  type        = number
  default     = 80
}