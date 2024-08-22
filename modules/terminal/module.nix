{ inputs, lib, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bash
    curl
    dosfstools
    git
    nano
    usbutils
  ];

  programs.fish.enable = true;

  programs.fish.shellAliases = {
    g = "git";
    nix-shell = "nix-shell --command (which fish)";
  };
}
