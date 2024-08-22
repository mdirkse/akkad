{ inputs, lib, config, options, pkgs, ... }: {
  documentation.man.enable = false;

  nix = {
    nixPath = [ "/etc/nix/path" ];
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      trusted-users = [ "maarten" ];
    };
  };

  nixpkgs = { config = { allowUnfree = true; }; };

  systemd.services.nix-daemon = { environment.TMPDIR = "/var/tmp"; };
}
