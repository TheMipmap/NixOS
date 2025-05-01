{ pkgs, lib, config, ... }:
let
  cfg = config.hyprshot;
  dependencies = with pkgs; [
    hyprshot
  ];
in
{
  options = {
    hyprshot = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mainMod SHIFT, S, Take Region Screenshot With Freeze, exec, hyprshot -m region --freeze -o ~/Pictures/Screenshots"
          ",Print, Take Window Screenshot, exec, hyprshot -m window -o ~/Pictures/Screenshots"
        ];
      };
    })
  ]);
}
