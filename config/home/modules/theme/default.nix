{ pkgs, lib, config, ... }:
let
  cfg = config.theme;
in
{
  options = {
    theme = {
      enable = lib.mkEnableOption "Enables theme";
      colorscheme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-mocha";
      };
      wallpaper = lib.mkOption {
        type = lib.types.str;
        default = "sunrise_new.jpg";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # home.file = {
    #   ".resources" = {
    #     source = ../../../../resources;
    #     executable = false;
    #     recursive = true;
    #   };
    # };

    fonts.fontconfig.enable = true;

    stylix = {
      enable = lib.mkDefault true;
      autoEnable = true;
      image = ../../../../resources/${cfg.wallpaper};
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";
      opacity.terminal = 0.85;


      targets = {
        gtk.enable = true;
        waybar.enable = true;
        firefox.profileNames = [ "Morten" ];
      };

      iconTheme = {
        enable = true;
        package = pkgs.catppuccin-papirus-folders;
        light = "Papirus-Light";
        dark = "Papirus-Dark";
      };
    };

    wayland.windowManager.hyprland.settings = {
      "exec-once" = [
        "hyprctl setcursor size 48"
      ];
    };
  };
}
