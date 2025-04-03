{ pkgs, lib, config, ... }:
let
  cfg = config.hyprlock;
  dependencies = with pkgs; [
    ibm-plex
    hyprlock
  ];
in {
  options = {
    hyprlock = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
      
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            no_fade_in = false;
            grace = 0;
            disable_loading_bar = false;
          };

          # background = [{
          #   monitor = "";
          #   path = "${config.home.homeDirectory}/.resources/${config.theme.wallpaper}";
          #   blur_passes = 2;
          #   contrast = 0.8916;
          #   brightness = 0.8172;
          #   vibrancy = 0.1696;
          #   vibrancy_darkness = 0.0;
          # }];

          label = [{
            # Current Date
            monitor = "";
            text = ''cmd[update:1000] echo "<span>$(date '+%A, %d %b')</span>"'';
            #color = "rgba(205, 214, 244, 0.75)";
            font_size = 50; # Was 25 before double for framework
            font_family = "IBM Plex Sans";
            position = "0, -75";
            halign = "center";
            valign = "top";
          } {
            # Current Time
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +'%H:%M')"'';
            #color = "rgba(250, 179, 135, .75)";
            font_size = 250; # Was 125 before double for framework
            font_family = "IBM Plex Sans";
            position = "0, -100";
            halign = "center";
            valign = "top";
          }];

          # input-field = [{
          #   monitor = "";

          #   fade_on_empty = false;
          #   font_family = "IBM Plex Sans";
          #   placeholder_text = "";
          # }];
        };
      };
    }
    (lib.mkIf config.hyprland.enable {
        wayland.windowManager.hyprland.settings = {
          bindd = [                                
            "$mainMod, L, Lock Screen, exec, hyprlock" 
          ];                                       
        };
    })
  ]);
}