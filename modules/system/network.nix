{ inputs, lib, config, options, pkgs, ... }: {
  boot.kernelParams = ["ipv6.disable=1"];
  boot.kernel.sysctl."net.ipv4.ip_forward" = 0;

  networking = {
    enableIPv6 = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 443 ];
    };
    hostId = "bf663db0";
    hostName = "akkad";
    timeServers = options.networking.timeServers.default ++ [ "0.nl.pool.ntp.org" "1.nl.pool.ntp.org" ];
    useDHCP = lib.mkDefault true;
    wireless.enable = false;
  };

  systemd.network.enable = true;
  systemd.network.netdevs."wlan0".enable = false; # make sure we don't touch the wifi
}
