{
  description = "geezus-flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    #unstable = {
    #  url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    #};
  };

  outputs = { self, nixpkgs, ... }:
    let
        lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      albemuth = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];      

      };



    };
  };
}
