{ inputs, lib, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bandwhich
    bash
    bat
    curl
    dnspeep
    dosfstools
    du-dust
    eza
    file
    git
    iputils
    lld
    lsof
    nano
    netcat
    nixfmt-classic
    nmap
    powertop
    procs
    pstree
    pv
    ripgrep
    unzip
    usbutils
    wget
    zip
  ];

  programs.fish.enable = true;

  programs.fish.shellAliases = {
    cat = "bat";
    du = "dust";
    g = "git";
    ll = "eza -la";
    ls = "eza";
    nix-shell = "nix-shell --command (which fish)";
    ps = "procs";
    rg = "rg --hidden --no-ignore";
    rgrep = "rg";
  };
}
