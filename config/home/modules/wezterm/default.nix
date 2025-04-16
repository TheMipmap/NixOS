{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.wezterm;
  dependencies = with pkgs; [ ];
in
{
  options = {
    wezterm = {
      enable = lib.mkEnableOption "Enable wezterm";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
      };

      # Enable wezterm
      programs.wezterm = {
        enable = true;
      };

    }
    (lib.mkIf config.hyprland.enable {
        wayland.windowManager.hyprland.settings = {
          bindd = [                                
            "$mainMod, A, Launch Wezterm, exec, wezterm" 
          ];                                       
        };
    })
  ]);
}
