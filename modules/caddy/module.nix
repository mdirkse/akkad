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

      virtualHosts = {
        "akkad.${secrets.fqdn}" = {
          logFormat = ''
            output file ${config.services.caddy.logDir}/access-akkad.log {
              roll_keep 0
            }
          '';
          extraConfig = ''
            respond 418
            tls /etc/ssl/${secrets.fqdn}.crt /etc/ssl/${secrets.fqdn}.key
          '';
        };

        "ha.${secrets.fqdn}" = {
          logFormat = ''
            output file ${config.services.caddy.logDir}/access-ha.log {
              roll_keep 0
            }
          '';
          extraConfig = ''
            reverse_proxy * localhost:8123
            tls /etc/ssl/${secrets.fqdn}.crt /etc/ssl/${secrets.fqdn}.key
          '';
        };

        "nr.${secrets.fqdn}" = {
          logFormat = ''
            output file ${config.services.caddy.logDir}/access-nr.log {
              roll_keep 0
            }
          '';
          extraConfig = ''
            reverse_proxy * localhost:1880
            tls /etc/ssl/${secrets.fqdn}.crt /etc/ssl/${secrets.fqdn}.key
          '';
        };
      };
  };
}

