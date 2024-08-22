{ inputs, lib, config, options, pkgs, ... }: {
  imports = [
    ./minimal.nix
    ./network.nix
    ./nix.nix
  ];

  boot = {
    kernel.sysctl."fs.inotify.max_user_watches" = 524288;
    loader.efi.canTouchEfiVariables = true;
    loader.grub.enable = false;
    loader.systemd-boot.enable = true;
    supportedFilesystems = [ "zfs" ];
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    enableRedistributableFirmware = true;
  };

  programs.command-not-found.enable = false;

  services = {
    dbus.implementation = "broker";
    openssh = {
      allowSFTP = false;
      enable = true;
      settings = {
        KbdInteractiveAuthentication = false;
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
  };

  security = {
    rtkit.enable = true;
    sudo.extraRules = [{
      users = [ "maarten" ];
      commands = [{
        command = "ALL";
        options = [ "SETENV" "NOPASSWD" ];
      }];
    }];
  };

  system.switch = {
    enable = false;
    enableNg = true;
  };

  systemd.services = {
    btattach = {
      before = [ "bluetooth.service" ];
      after = [ "dev-ttyAMA0.device" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
      };
    };
  };

  time.timeZone = "Europe/Amsterdam";

  users.users = {
    maarten = {
      extraGroups = [ "wheel" ];
      initialPassword = "paratodostodo";
      isNormalUser = true;
      openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcUcPxEtlNoXBg6jvIeqr/3hc9GgQplrQtyd215bi5cDIeo7qx6INlOhrZ/M88TN1/HllRi/ygWZWwUxL2aruzB2jLmbN2cGpAeQFH1u8daZT0GtZv4Iu7426k5UXEjd6QxtJEXMUeg8czN9fB7aqntjfl7uVmVl/cozqbM7bF00F8MCKGERpWjglDsuqC7qcK8kMVmcgoe8cGpffj+2zUL/HiMZptJN2GXpN7kDIKUNrUezFLG1osH2lAeox6W6tEG18w+UtgQ4qSEs4ob9MdQBOMgv/8RuAft9ma4yxrEKoy8+ogKacuy6gU/U5Y7ulAS6TWqto+8VKQyRm/vfc5 maarten@lagash"];
      shell = pkgs.fish;
    };
  };
}
