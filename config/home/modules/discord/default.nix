{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.discord;
  dependencies = with pkgs; [ discord ];
in 
{
  options = {
    discord = {
      enable = lib.mkEnableOption "Enable discord";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
