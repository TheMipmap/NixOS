{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.foot;
  dependencies = with pkgs; [ ];
in
{
  options = {
    foot = {
      enable = lib.mkEnableOption "Enable foot";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
      };

      # Foot Configuration
      programs.foot = {
        enable = true;
      };

      # Foot Settings
      programs.foot.settings = {
        main = {
          term = "xterm-256color";
          dpi-aware = "yes";
        };

        colors = {
          alpha = "0.9";
        };

        mouse = {
          hide-when-typing = "yes";
        };
      };
    }
    (lib.mkIf config.hyprland.enable {
        wayland.windowManager.hyprland.settings = {
          # bindd = [                                
          #   "$mainMod, R, Launch Terminal, exec, foot" 
          # ];                                       
        };
    })
  ]);
}
