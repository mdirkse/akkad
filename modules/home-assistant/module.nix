{ inputs, lib, config, pkgs, ... }: {
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
      http = {
        server_host = "127.0.0.1";
        trusted_proxies = "127.0.0.1";
        use_x_forwarded_for = true;
      };
    };
  };
}
