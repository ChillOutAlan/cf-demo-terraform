// Allow IP address
variable "personal_ip" {
  description = "IP address of your Current Location"
  type        = string
  sensitive = true
}

// Cloudflare User Email
variable "cloudflare_email" {
  description = "Cloudflare User Email"
  type = string
}

// Cloudflare API Token
variable "cloudflare_api_token" {
  description = "Cloudflare User API Key"
  type = string
  sensitive = true
}

// Cloudflare Zone
variable "cloudflare_zone_id" {
  description = "Cloudflare Zone (ID) to Target"
  type = string
}

// Cloudflare Account ID
variable "cloudflare_account_id" {
  description = "Account ID associated with Cloudflare Zone"
  type = string
  sensitive = true
}