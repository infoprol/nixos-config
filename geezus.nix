{ config, pkgs, ... }:
{
    home.username = "geezus";
    home.homeDirectory = "/home/geezus";
    home.stateVersion = "25.11";
    programs.git.enable = true;
    programs.bash = {
      enable = true;
      shellAliases = {
        heythere = "echo yeah hey batch atchya";
      };
      profileExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec uwsm start -S hyprland-uwsm.desktop
        fi
      '';
    };
}
