{ pkgs, lib, config, ... }:
let
  cfg = config.waybar;
  dependencies = with pkgs; [ waybar ];

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

      # home.file = {
      #   ".config/waybar" = {
      #     source = ./sources;
      #     executable = false;
      #     recursive = true;
      #   };
      # };
    }
    # (lib.mkIf config.hyprland.enable {
    #   wayland.windowManager.hyprland = {
    #     settings = {
    #       "exec-once" = [
    #         "waybar"
    #       ];
    #       bindd = [
    #         "$mod, w, Toggle Waybar, exec,  killall waybar || killall .waybar-wrapped || waybar"
    #       ];
    #     };
    #   };
    # })
  ]);
}
