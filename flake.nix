{
  description = "nixos unstable flake with home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    

  

    # caelestia-shell = {
    #   url = "github:caelestia-dots/shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };


    #noctalia = {
    #  url = "github:noctalia-dev/noctalia-shell";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

  

  };

  outputs = { self, nixpkgs, home-manager, dms, ... }@inputs: {
    nixosConfigurations.altair = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
#        home-manager.users.geezus = import ./geezus.nix;
        home-manager.users.infoprol = import ./infoprol.nix;
      }
      ];
    };
  };
}
