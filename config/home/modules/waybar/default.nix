{ pkgs, lib, config, ... }:
let
  cfg = config.waybar;
  dependencies = with pkgs; [ ];

in
{
  options = {
    waybar = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
        description = "Enable waybar (Defaults to hyprland.enable)";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      # Remove default stylix css
      stylix.targets.waybar.addCss = false;

      programs.waybar = {
        enable = true;

        settings = lib.importJSON ./sources/config;
        style = lib.mkAfter (builtins.readFile ./sources/style.css);
      };

    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          "exec-once" = [
            "waybar"
          ];
          # bindd = [
          #   "$mod, w, Toggle Waybar, exec,  killall waybar || killall .waybar-wrapped || waybar"
          # ];
        };
      };
    })
  ]);
}
