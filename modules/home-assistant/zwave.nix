{ inputs, lib, config, pkgs, ... }: let
  zwave_keys = "home-assistant/zwave-keys.json";
  zwave_user = "zwave-js"; # as defined in the zwave-js-server unit file
  in {

  users.users."${zwave_user}" = {
    isSystemUser = true;
    description  = "Zwave user";
    group = zwave_user;
  };
  users.groups."${zwave_user}" = {};

  environment.etc."${zwave_keys}" = {
    mode = "0400";
    source = ../secrets/zwave-keys.json;
    user = zwave_user;
  };

  services.zwave-js = {
   enable = true;
   serialPort = "/dev/ttyUSB0";
   secretsConfigFile = "/etc/${zwave_keys}";
  };

}
