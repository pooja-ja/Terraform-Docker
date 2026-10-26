locals {
  # Generates a tag like: 2026-10-26_1209
  dynamic_tag = formatdate("YYYY-MM-DD_hhmm", timestamp())
}

resource "docker_image" "app_image" {
  # Combines username, image name, and tag (e.g., username/my-app:latest)
  name = "registry-1.docker.io/${var.docker_hub_username}/${var.image_name}:${local.dynamic_tag}"
  build {
    context    = "../"       # Looks for a 'Dockerfile' in the current directory
    dockerfile = "Dockerfile" 
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "src/**") : filesha1(f)]))
  }
}

resource "docker_registry_image" "push_to_hub" {
  name          = docker_image.app_image.name
  keep_remotely = true
}

# 2. Deploy the container using the pushed image
resource "docker_container" "app_container" {
  name  = "my-running-app"
  image = docker_image.app_image.image_id

  ports {
    internal = 80
    external = 80
  }
}