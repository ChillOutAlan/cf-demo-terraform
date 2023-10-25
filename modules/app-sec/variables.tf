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
  description = "Target Cloudflare Zone"
  type = string
}
