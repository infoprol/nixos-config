{ pkgs, inputs, ... }:
{
  home-manager.users.geezus = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
    };
  };
}
