{ inputs, lib, config, pkgs, ... }: let
  zwave_keys = home-assistant/zwave-keys.json;
in {
  environment.etc."${zwave_keys}".source = ../secrets/zwave-keys.json;

  services.home-assistant = {
    enable = true;
    extraComponents = [
      "esphome"
      "homekit_controller"
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

  services.zwave-js = {
   enable = true;
   serialPort = "/dev/ttyUSB0";
   secretsConfigFile = "/etc/${zwave_keys}";
  };
}
