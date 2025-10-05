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
    
#    hyprland.url = "github:hyprwm/Hyprland";
#    hyprland-plugins = {
#      url = "github:hyprwm/hyprland-plugins";
#      inputs.hyprland.follows = "hyprland";
#    };
  };
  
  outputs =
  {   self, nixpkgs,
      home-manager,
      catppuccin,
#      hyprland,
#      hyprland-plugins,
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
#          {
#          wayland.windowManager.hyprland = {
#            enable = true;
#            # set the flake package
#            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
#            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
#          };
#        }
        ];
      };
    };
  };
}


