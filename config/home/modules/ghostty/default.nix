{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.ghostty;
  dependencies = with pkgs; [ ];
in
{
  options = {
    ghostty = {
      enable = lib.mkEnableOption "Enable ghostty";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };

    # Ghostty Configuration
    programs.ghostty = {
      enable = true;

      # Settings
      settings = {
        clipboard-read = "allow";
        clipboard-write = "allow";
        background-opacity = 0.90;
        background-blur = 20;
        gtk-single-instance = true; # Significant speedup for multiple instances
      };
    };
  };
}
