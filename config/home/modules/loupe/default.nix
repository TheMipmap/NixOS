{ pkgs, lib, config, ... }:
let
  cfg = config.loupe;
  dependencies = with pkgs; [ loupe ];

in
{
  options = {
    loupe = {
      enable = lib.mkEnableOption "Enable loupe";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
