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
      file_server
      root * ${
        pkgs.runCommand "testdir" {} ''
          mkdir "$out"
          echo hello world > "$out/example.html"
        ''
      }
    '';
    };
  }

