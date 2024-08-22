{
  description = "Home Assistant Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      nixModules = [ ./configuration.nix ];
    in {
      nixosConfigurations = {
        pi = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          system = "aarch64-linux";
          modules = [ ./hardware/pi.nix ] ++ nixModules;
        };
      };
    };
}
