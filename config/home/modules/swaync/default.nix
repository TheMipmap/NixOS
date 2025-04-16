{ pkgs, lib, config, ... }:
let
  cfg = config.swaync;
  dependencies = with pkgs; [
    swaynotificationcenter # Notification daemon
    libnotify # Sends desktop notifications to notification daemon
  ];
in {
  options = {
    swaync = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
      
      # Enable Sway Notification Center
      services.swaync = {
        enable = true;
        settings = lib.importJSON ./src/config.json;
      };
    }
    (lib.mkIf config.hyprland.enable {
        wayland.windowManager.hyprland.settings = {
          exec-once = [ "swaync" ];                  
        };
    })
  ]);
}