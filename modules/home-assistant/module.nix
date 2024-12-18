{ inputs, lib, config, pkgs, ... }: {
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
  };
}
