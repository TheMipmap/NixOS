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
        default = "sunset.jpg";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".resources" = {
        source = ../../../../resources;
        executable = false;
        recursive = true;
      };
    };

    fonts.fontconfig.enable = true;

    stylix = {
      enable = lib.mkDefault true;
      autoEnable = true;
      image = ../../../assets/${cfg.wallpaper};
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";

      targets = {
        gtk.enable = true;
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
        "hyprctl setcursor size 24"
      ];
    };
  };
}
