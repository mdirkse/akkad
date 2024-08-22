{ inputs, lib, config, pkgs, ... }: {
  services.caddy = {
    enable = true;
    virtualHosts."akkad".extraConfig = ''
    encode gzip
    file_server
    root * ${
      pkgs.runCommand "testdir" {} ''
        mkdir "$out"
        echo hello world > "$out/example.html"
      ''
    }
  '';
  };
}
