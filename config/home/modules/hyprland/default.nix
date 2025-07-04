{ pkgs, lib, config, ... }:
let
  cfg = config.hyprland;
  dependencies = with pkgs; [
    rofi-power-menu
    font-awesome
    nerdfonts
  ];

in
{
  imports = [
    ./input
    ./keybinds
    ./theme
  ];
  options = {
    hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      # Install dependencies
      home.packages = dependencies;

      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = lib.mkForce "material";
        plugins = with pkgs;
          [
            (rofi-calc.override {
              rofi-unwrapped = rofi-wayland-unwrapped;
            })
          ];
      };

      # Modify hyprland config
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          ##--- Set programs ---##
          "$terminal" = "ghostty";
          "$fileManager" = "wezterm start -- yazi";
          "$menu" = "rofi -show drun -drun-display-format {name}";

          ##--- Set environment variables ---##
          env = [
            "XCURSOR_SIZE,24"
            "HYPRCURSOR_SIZE,24"
          ];

          ##--- Ensure apps don't scale (resulting in blurry) ---##
          xwayland = {
            force_zero_scaling = "true";
          };

          ##--- Window Rules ---##
          windowrulev2 = [
            "suppressevent maximize, class:.*" # Ignore maximize requests from apps.
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # Fix some dragging issues with XWayland
          ];

          ##--- Misc Settings ---##
          misc = {
            focus_on_activate = true; # Focus windows when they are activated
          };
        };
        extraConfig = ''
          exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        '';
      };
    }
  ]);
}
