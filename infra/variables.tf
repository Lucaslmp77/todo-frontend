variable "gcp_project_id" {
  description = "meu-projeto-stage"
  type        = string
}

variable "region" {
  description = "Região onde os recursos serão criados."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Nome do cluster GKE."
  type        = string
}