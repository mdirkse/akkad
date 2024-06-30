{ inputs, lib, config, pkgs, ... }: {
  services.caddy = {
    enable = true;
  };
}
