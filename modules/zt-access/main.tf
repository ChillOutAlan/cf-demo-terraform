// Access Application
resource "cloudflare_access_application" "access_app_portainer_app" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "Portainer Self-Hosted Application"
  domain                    = "portainer.zt.pondverse.win"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}


# Allowing Access only to the Cloudflare Email
resource "cloudflare_access_policy" "portainer_policy" {
  application_id = cloudflare_access_application.access_app_portainer_app.id
  zone_id        = var.cloudflare_zone_id
  name           = "Portainer Access Policy"
  precedence     = "1"
  decision       = "allow"

  include {
    email = ["faux_email@cloudflare.com"]
  }

  require {
    ip = [var.personal_ip]
  }
}