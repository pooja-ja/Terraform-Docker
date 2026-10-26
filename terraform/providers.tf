terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configure the Docker provider with your credentials
provider "docker" {
  registry_auth {
    address  = "registry-1.docker.io"
    username = var.docker_hub_username
    password = var.docker_hub_password
  }
}
