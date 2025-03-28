{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.wezterm;
  dependencies = with pkgs; [ ];
in
{
  options = {
    wezterm = {
      enable = lib.mkEnableOption "Enable wezterm";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };

    # Ghostty Configuration
    programs.wezterm = {
      enable = true;
    };
  };
}
