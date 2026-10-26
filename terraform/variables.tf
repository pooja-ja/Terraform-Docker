variable "docker_hub_username" {
  type        = string
  description = "Docker Hub username"
}

variable "docker_hub_password" {
  type        = string
  description = "Docker Hub Personal Access Token or password"
  sensitive   = true # Hides the value in console outputs
}

variable "image_name" {
  type        = string
  default     = "my-app"
  description = "Name of the Docker image"
}
