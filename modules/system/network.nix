{ inputs, lib, config, options, pkgs, ... }: {
  boot.kernel.sysctl."net.ipv4.ip_forward" = 0;

  networking = {
    enableIPv6 = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 443 1880 8123 ];
    };
    hostId = "bf663db0";
    hostName = "akkad";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "0.nl.pool.ntp.org" "1.nl.pool.ntp.org" ];
    wireless.enable = false;
  };
}
