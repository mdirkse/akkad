{
  lib,
  buildHomeAssistantComponent,
  fetchFromGitHub,
  ...
}:

buildHomeAssistantComponent rec {
  owner = "zachowj";
  domain = "nodered";
  version = "4.1.2";

  src = fetchFromGitHub {
    inherit owner;
    repo = "hass-node-red";
    tag = "v${version}";
    hash = "sha256-qRQ4NMKmZUQ9wSYR8i8TPbQc3y69Otp7FSdGuwph14c=";
  };

  meta = with lib; {
    description = "Companion Component for node-red-contrib-home-assistant-websocket";
    homepage = "https://github.com/zachowj/hass-node-red/";
    changelog = "https://github.com/zachowj/hass-node-red/releases/tag/${version}";
    license = licenses.mit;
  };
}
