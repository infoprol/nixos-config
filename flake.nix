{
  description = "matt flake";

  inputs = {
    #nixpkgs = {
    #  url = "github:NixOS/nixpkgs/nixos-25.05";
    #};
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix/release-25.05";
      # im not sure the following follows is necessary or not;
      # i suppose it depends on what follows here means...?
      inputs.nixpkgs.follows = "home-manager";
    };
  };
  
  outputs =
  {   self, nixpkgs,
      home-manager, catppuccin,
      ...
  }:
    let
      system = "x86_64-linux"; 
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system}; 
    in {
    nixosConfigurations = {
      bellatrix = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
    homeConfigurations = {
      infoprol = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          catppuccin.homeModules.catppuccin
        ];
      };
    };
  };
}
