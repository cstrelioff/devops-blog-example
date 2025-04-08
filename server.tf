resource "digitalocean_droplet" "www" {
  image  = "ubuntu-22-04-x64"
  name   = "www-nginx"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.do_test.id
  ]
}

# add domain
resource "digitalocean_domain" "default" {
  name       = var.domain
  ip_address = digitalocean_droplet.www.ipv4_address
}

# output server's ip
output "ip_address" {
  value = digitalocean_droplet.www.ipv4_address
}
