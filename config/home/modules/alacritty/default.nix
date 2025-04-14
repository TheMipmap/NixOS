{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.alacritty;
  dependencies = with pkgs; [ ];
in
{
  options = {
    alacritty = {
      enable = lib.mkEnableOption "Enable alacritty";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
      };

      # Alacritty Configuration
      programs.alacritty = {
        enable = true;
      };

    }
    # (lib.mkIf config.hyprland.enable {
    #     wayland.windowManager.hyprland.settings = {
    #       bindd = [                                
    #         "$mainMod, A, Launch Alacritty, exec, alacritty" 
    #       ];                                       
    #     };
    # })
  ]);
}
