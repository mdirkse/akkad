{ inputs, lib, config, pkgs, ... }:
  let
    secrets = import ../secrets/secrets.nix;
  in {
    services.caddy = {
      enable = true;
      enableReload = false; # Reload won't work as the admin API is turned off

      globalConfig = ''
        admin off
        auto_https off
      '';

      virtualHosts."ha.${secrets.fqdn}".extraConfig = ''
        log {
          output file /var/log/caddy/ha.log {
            roll_keep 0
          }
	      }
        reverse_proxy * localhost:8123
        tls /etc/ssl/${secrets.fqdn}.crt /etc/ssl/${secrets.fqdn}.key
      '';

      virtualHosts."nr.${secrets.fqdn}".extraConfig = ''
        log {
          output file /var/log/caddy/nr.log {
            roll_keep 0
          }
	      }
        reverse_proxy * localhost:1880
        tls /etc/ssl/${secrets.fqdn}.crt /etc/ssl/${secrets.fqdn}.key
      '';
    };
  }

