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

      virtualHosts."akkad.${secrets.fqdn}".extraConfig = ''
      reverse_proxy /ha/* localhost:8123
      reverse_proxy /nr/* localhost:1880

      @not-known {
	      not path /ha/* /nr/*
      }

      redir @not-known /ha/ permanent

      tls /etc/ssl/${secrets.fqdn}.crt /etc/ssl/${secrets.fqdn}.key
    '';
    };
  }

