{ pkgs, lib, config, ... }:
let
  cfg = config.calculator;
  dependencies = with pkgs; [ gnome-calculator ];

in
{
  options = {
    calculator = {
      enable = lib.mkEnableOption "Enable calculator";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
      };
    }
    (lib.mkIf config.hyprland.enable {
        wayland.windowManager.hyprland.settings = {
          bindel = [                                
            ", XF86Calculator, exec, gnome-calculator"
          ];

          # Mak
        };
    })
  ]);
}
