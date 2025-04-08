variable "do_token" {
  type        = string
  description = "Personal access token setup at digitalocean."
}

variable "domain" {
  type        = string
  description = "The domain name for the server"
  default     = "example.com"
}
