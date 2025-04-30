##
## provider
##
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

##
## server
##
resource "digitalocean_droplet" "www" {
  image  = "ubuntu-22-04-x64"
  name   = "www-nginx"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  ipv6   = true
  ssh_keys = [
    data.digitalocean_ssh_key.do_test.id
  ]
}

# add domain
resource "digitalocean_domain" "default" {
  name       = var.domain
  ip_address = digitalocean_droplet.www.ipv4_address
}

# add an A record for www.domain
resource "digitalocean_record" "www" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "www"
  value  = digitalocean_droplet.www.ipv4_address
}

# output server's ip
output "ip_address" {
  value = digitalocean_droplet.www.ipv4_address
}

##
## data
##
# ssh key uploaded to digitalocean
data "digitalocean_ssh_key" "do_test" {
  name = "do_test"
}

##
## variables
##
variable "do_token" {
  type        = string
  description = "Personal access token setup at digitalocean."
}

variable "domain" {
  type        = string
  description = "The domain name for the server"
  default     = "example.com"
}
