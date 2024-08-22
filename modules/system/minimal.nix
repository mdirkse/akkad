# From https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/minimal.nix
# Turn off all sorts of unnecessary stuff
{lib, ...}:
let
  inherit (lib) mkDefault;
in {
  documentation = {
    enable = mkDefault false;
    doc.enable = mkDefault false;
    info.enable = mkDefault false;
    man.enable = mkDefault false;
    nixos.enable = mkDefault false;
  };

  environment = {
    defaultPackages = mkDefault [ ];  # IE Perl is a default package.
    stub-ld.enable = mkDefault false;
  };

  programs = {
    # The lessopen package pulls in Perl.
    less.lessopen = mkDefault null;
    command-not-found.enable = mkDefault false;
  };

  # This pulls in nixos-containers which depends on Perl.
  boot.enableContainers = mkDefault false;

  services.udisks2.enable = mkDefault false;

  xdg = {
    autostart.enable = mkDefault false;
    icons.enable = mkDefault false;
    mime.enable = mkDefault false;
    sounds.enable = mkDefault false;
  };
}
