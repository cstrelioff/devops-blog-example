# ssh key uploaded to digitalocean
data "digitalocean_ssh_key" "do_test" {
  name = "do_test"
}
