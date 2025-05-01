{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.hyprland.theme;
in {
  options = {
    hyprland.theme = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
      animations.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.theme.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.targets = {
      hyprland.enable = true;
    };

    wayland.windowManager.hyprland.settings = (lib.mkMerge [
      {
        cursor = {
          "no_hardware_cursors" = "true";
        };

        general = {
          "gaps_in" = "5";
          "gaps_out" = "10";
          "border_size" = "3";
          "resize_on_border" = "true" ; # Allow resizing windows by clicking and dragging on borders and gaps
          "allow_tearing" = "false";
          "layout" = "dwindle";
        };

        dwindle = {
          "pseudotile" = "true";
          "preserve_split" = "true";
        };

        master = {
          "new_status" = "master";
        };

        misc = {
          "force_default_wallpaper" = "-1";
          #"disable_hyprland_logo" = "false";
        };

        decoration = {
          rounding = "10";
          
          active_opacity = "1.0";
          inactive_opacity = "1.0";
          fullscreen_opacity = "1.0";

          shadow = {
            enabled = "true";
            range = "4";
            render_power = "3";
          };

          blur = {
            enabled = "true";
            size = "3";
            passes = "1";
            vibrancy = "0.1696";
          };
        };
      }
      (lib.mkIf cfg.animations.enable {
        animations = {
          enabled = "yes, please :)";

          bezier = [
            "easeOutQuint, 0.23, 1, 0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear, 0, 0, 1, 1"
            "almostLinear, 0.5, 0.5, 0.75, 1.0"
            "quick, 0.15, 0, 0.1, 1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };
      })
    ]);
  };
}
