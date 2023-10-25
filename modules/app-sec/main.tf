// Toggle Settings ONLY to override the default.
resource "cloudflare_zone_settings_override" "toggle" {
  zone_id = var.cloudflare_zone_id
  settings {
    // SSL -> Overview
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    ssl                      = "strict"
    always_use_https         = "on"

    // Network
    privacy_pass = "on"
    http3 = "on"
    response_buffering = "on"
    websockets = "on"
    ip_geolocation = "on"
    true_client_ip_header = "on"
    
    // Security -> Settings
    browser_check = "on"
    security_level = "high"
    challenge_ttl = 2700

    // Speed -> Optimization -> Content Optmization
    brotli                   = "on"
    mirage                   = "on"
    rocket_loader            = "on"
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }

    // Speed -> Optimization -> Image Optmization
    polish                   = "lossless"  
    webp                     = "on"
    security_header {
      enabled = true
    }
  }
}

// Cloudflare Managed Ruleset
resource "cloudflare_ruleset" "cf_managed_rulesets" {
  kind    = "zone"
  name    = "managed_rules" //rename from cf-terraform
  phase   = "http_request_firewall_managed"
  zone_id = var.cloudflare_zone_id
  rules {
    action = "execute"
    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      version = "latest"
    }
    enabled    = true
    expression = "true"
  }
  rules {
    action = "execute"
    action_parameters {
      id      = "c2e184081120413c86c3ab7e14069605"
      version = "latest"
    }
    enabled    = true
    expression = "true"
  }
  rules {
    action = "execute"
    action_parameters {
      id      = "efb7b8c949ac4650a09736fc376e9aee"
      version = "latest"
    }
    enabled    = true
    expression = "true"
  }
}

//Firewall Rulesets
resource "cloudflare_ruleset" "cf_custom_rulesets" {
  kind    = "zone"
  name    = "custom_waf" //rename
  phase   = "http_request_firewall_custom"
  zone_id = var.cloudflare_zone_id
  rules {
    action      = "challenge"
    description = "Home Page Automation Check"
    enabled     = true
    expression  = "(http.host eq \"terraform.pondverse.win\")"
  }
  rules {
    action      = "block"
    description = "mTLS-enforced authentication"
    enabled     = true
    expression  = "(not cf.tls_client_auth.cert_verified and http.request.uri.path in {\"/cart\"})"
  }
  rules {
    action      = "block"
    description = "Blocking IPv6 Source "
    enabled     = true
    expression  = "(ip.src eq 2a09:bac5:c533:15d7::22d:23)"
  }
} 
