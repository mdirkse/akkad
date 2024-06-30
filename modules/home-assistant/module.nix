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
    };
  };

  #services.zwave-js = {
  #  enable = true;
  #  serialPort = "/dev/ttyUSB0";
  #};
}
