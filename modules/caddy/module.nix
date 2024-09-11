{ inputs, lib, config, pkgs, ... }:
  let
    secrets = import ../secrets/secrets.nix;
  in {
    services.caddy = {
      enable = true;

      globalConfig = ''
        admin off
        auto_https off
      '';

      virtualHosts."akkad.${secrets.fqdn}".extraConfig = ''
      encode gzip
      reverse_proxy /ha/* localhost:8123
      reverse_proxy /nr/* localhost:1880

      @not-known {
	      not path /ha/* /nr/*
      }

      redir @not-known /ha permanent
    '';
    };
  }

