{ inputs, lib, config, options, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    "${
      builtins.fetchTarball {
        url =
          "https://github.com/nix-community/disko/archive/refs/tags/v1.4.1.tar.gz";
        sha256 = "1hm5fxpbbmzgl3qfl6gfc7ikas4piaixnav27qi719l73fnqbr8x";
      }
    }/module.nix"
    ./hardware/disko-config.nix
    ./modules/caddy/module.nix
    ./modules/home-assistant/module.nix
    ./modules/node-red/module.nix
    ./modules/terminal/module.nix
  ];

  nixpkgs = { config = { allowUnfree = true; }; };

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  networking.hostId = "bf663db0";
  networking.hostName = "akkad";
  networking.networkmanager.enable = true;

  services.openssh = {
    settings = {
      allowSFTP = false; # Don't set this if you need sftp
      kbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
    };
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.supportedFilesystems = [ "zfs" ];

  boot.kernel.sysctl."fs.inotify.max_user_watches" = 524288;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 0;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  boot.tmp.useTmpfs = true;
  systemd.services.nix-daemon = {
    environment.TMPDIR = "/var/tmp";
  };

  networking.wireless.enable = false;

  networking.timeServers = options.networking.timeServers.default ++ [ "0.nl.pool.ntp.org" "1.nl.pool.ntp.org" ];
  networking. enableIPv6 = false;

  programs.command-not-found.enable = false;
  security.rtkit.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 1880 8123 ];
  };

  nix.settings.allowed-users = [ "@wheel" ];

  documentation.man.enable = false;

  time.timeZone = "Europe/Amsterdam";

  system.switch = {
    enable = false;
    enableNg = true;
  };

  users.users = {
    maarten = {
      extraGroups = [ "wheel" ];
      initialPassword = "paratodostodo";
      isNormalUser = true;
      openssh.authorizedKeys.key = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcUcPxEtlNoXBg6jvIeqr/3hc9GgQplrQtyd215bi5cDIeo7qx6INlOhrZ/M88TN1/HllRi/ygWZWwUxL2aruzB2jLmbN2cGpAeQFH1u8daZT0GtZv4Iu7426k5UXEjd6QxtJEXMUeg8czN9fB7aqntjfl7uVmVl/cozqbM7bF00F8MCKGERpWjglDsuqC7qcK8kMVmcgoe8cGpffj+2zUL/HiMZptJN2GXpN7kDIKUNrUezFLG1osH2lAeox6W6tEG18w+UtgQ4qSEs4ob9MdQBOMgv/8RuAft9ma4yxrEKoy8+ogKacuy6gU/U5Y7ulAS6TWqto+8VKQyRm/vfc5 maarten@lagash"];
      shell = pkgs.fish;
    };
  };

  security.sudo.extraRules = [{
    users = [ "maarten" ];
    commands = [{
      command = "ALL";
      options = [ "SETENV" "NOPASSWD" ];
    }];
  }];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion  # You can import other home-manager modules here
  system.stateVersion = "23.11";
}
