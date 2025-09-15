{
  description = "geezus-flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #unstable = {
    #  url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    #};
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
        lib = nixpkgs.lib;
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      albemuth = lib.nixosSystem {
        inherit system;
	modules = [ ./configuration.nix ];      
      };



    };
    homeConfigurations = {
      geezus = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [ ./home.nix ];
      };
    };
  };
}
