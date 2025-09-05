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

      # Link scripts to Waybar config
      home.file = {
        ".config/waybar/scripts/get_main_kb.sh" = {
          source = ./scripts/get_main_kb.sh;
          executable = true;
        };
      };

      programs.waybar = {
        enable = true;

        settings = lib.importJSON ./src/config.json;
        style = lib.mkAfter (builtins.readFile ./src/style.css);
      };
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          "exec-once" = [
            "waybar"
          ];
          bindd = [
            "$mainMod, w, Toggle Waybar, exec,  pkill waybar || pkill .waybar-wrapped || waybar"
          ];
        };
      };
    })
  ]);
}
