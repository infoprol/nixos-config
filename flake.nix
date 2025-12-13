{
  description = "nixos 25.11";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #catppuccin = {
    #  url = "github:catppuccin/nix/release-25.11";
    #  # im not sure the following follows is necessary or not;
    #  # i suppose it depends on what follows here means...?
    #  inputs.nixpkgs.follows = "home-manager";
    # };
  };
  
  outputs =
  {   self,
      nixpkgs,
      home-manager,
      # catppuccin,
      ...
  }: {
    nixosConfigurations = {
      bellatrix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.geezus = import ./geezus.nix;
                    backupFileExtension = "bak";
                };
            }
        ]
      };
    };
  };

}
