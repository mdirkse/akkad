{ inputs, lib, config, pkgs, ... }:
  let
    secrets = import ../secrets/secrets.nix;
  in {
  imports = [ ./zwave.nix ];

  services.home-assistant = {
    enable = true;
    customComponents = [
      (config.services.home-assistant.package.python.pkgs.callPackage ./hass-node-red-package.nix {})
    ];
    extraComponents = [
      "backup"
      "bluetooth"
      "bluetooth_adapters"
      "esphome"
      "evohome"
      "homekit_controller"
      "isal"
      "met"
      "radio_browser"
      "zha"
      "zwave_js"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      evohome = {
        username = secrets.evohome.username;
        password = secrets.evohome.password;
      };
      http = {
        server_host = "127.0.0.1";
        trusted_proxies = "127.0.0.1";
        use_x_forwarded_for = true;
      };
    };
  };
}
