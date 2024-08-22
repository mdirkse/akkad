{ inputs, lib, config, options, pkgs, ... }: {
  imports = [
    "${
      builtins.fetchTarball {
        url = "https://github.com/nix-community/disko/archive/refs/tags/v1.4.1.tar.gz";
        sha256 = "1hm5fxpbbmzgl3qfl6gfc7ikas4piaixnav27qi719l73fnqbr8x";
      }
    }/module.nix"
    ./hardware/disko-config.nix
    ./modules/caddy/module.nix
    ./modules/home-assistant/module.nix
    ./modules/node-red/module.nix
    ./modules/system/module.nix
    ./modules/terminal/module.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
