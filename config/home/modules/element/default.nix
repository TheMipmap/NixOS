{ pkgs, lib, config, ... }:
let
  cfg = config.element;
  dependencies = with pkgs; [ element-desktop ];

in
{
  options = {
    element = {
      enable = lib.mkEnableOption "Enable element";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
