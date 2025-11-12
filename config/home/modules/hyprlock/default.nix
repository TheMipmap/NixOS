{ pkgs, lib, config, ... }:
let
  cfg = config.hyprlock;
  dependencies = with pkgs; [
    ibm-plex
    hyprlock
  ];
in
{
  options = {
    hyprlock = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
      timeout = lib.mkOption {
        type = lib.types.int;
        default = 240;
        description = "Time in seconds before the screen is locked due to inactivity.";
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
            color = "rgba(137, 180, 250, 0.75)"; # TODO: Convert to RGBA from stylix palette
            font_size = 50;
            font_family = "IBM Plex Sans";
            position = "0, +75";
            halign = "center";
            valign = "bottom";
          }
            {
              # Current Time
              monitor = "";
              text = ''cmd[update:1000] echo "$(date +'%H:%M')"'';
              color = "rgba(246, 140, 74, 0.75)";
              font_size = 250;
              font_family = "IBM Plex Sans";
              position = "0, -100";
              halign = "center";
              valign = "top";
            }
            {
              # Seconds
	      monitor = "";
	      text = ''cmd[update:1000] echo "$(date +'%S')"'';
	      color = "rgba(246, 140, 74, 0.75)";
	      font_size = 125;
	      font_family = "IBM Plex Sans";
	      position = "550, -275";
	      halign = "center";
	      valign = "top";
	    }
	    ];

          # input-field = [{
          #   monitor = "";

          #   fade_on_empty = false;
          #   font_family = "IBM Plex Sans";
          #   placeholder_text = "";
          # }];
        };
      };

      ###- Configure Hypridle -###
      services.hypridle = {
        enable = true;

        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock"; # Only run one instance of hyprlock
            before_sleep_cmd = "hyprlock";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };

          listener = [
            {
              timeout = config.hyprlock.timeout;
              on-timeout = "hyprlock";
            }
            {
              timeout = config.hyprlock.timeout * 2;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = config.hyprlock.timeout * 4;
              on-timeout = "systemctl suspend";
            }
          ];
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
