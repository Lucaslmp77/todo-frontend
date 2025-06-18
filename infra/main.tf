provider "google" {
  project = var.gcp_project_id
  region  = var.region
}

# Cria o repositório no Artifact Registry para as imagens Docker
resource "google_artifact_registry_repository" "app_repo" {
  location      = var.region
  repository_id = "app-images" # Nome do repositório
  description   = "Docker repository for our applications"
  format        = "DOCKER"
}

# Cria o cluster GKE
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
  subnetwork = "default"
}

# Pool de nós padrão para o cluster
resource "google_container_node_pool" "primary_nodes" {
  name       = "default-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 2 # Inicie com 2 nós

  node_config {
    preemptible  = false # Use 'true' para economizar custos em Stage
    machine_type = "e2-medium" # Bom para começar
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# Saída do nome do cluster para usar na pipeline
output "gke_cluster_name" {
  value = google_container_cluster.primary.name
}

# Saída do nome do repositório de artefatos
output "artifact_registry_name" {
  value = google_artifact_registry_repository.app_repo.name
}