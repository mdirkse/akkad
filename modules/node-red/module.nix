{ inputs, lib, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ ];

  services.node-red = {
    enable = true;
    withNpmAndGcc = true;
    # settings = {
    #   httpAdminRoot = "/admin";
    #   httpNodeRoot = "/node";
    #   userDir = "${config.home}/.node-red";
    #   flowFile = "flows.json";
    #   credentialSecret = "a-secret-key";
    #   uiPort = 1880;
    #   functionGlobalContext = {
    #     // add custom nodes here
    #   };
    #   editorTheme = {
    #     projects = {
    #       enabled = true;
    #     };
    #   };
    # };
  };
}
