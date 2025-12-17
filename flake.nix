{
  description = "nixos unstable flake with home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.bellatrix = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix

	home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.geezus = import ./geezus.nix;
	}
      ];
    };
  };
}
