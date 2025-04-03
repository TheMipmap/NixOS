{ pkgs, lib, config, ... }:
let
  cfg = config.evince;
  dependencies = with pkgs; [ evince ];

in
{
  options = {
    evince = {
      enable = lib.mkEnableOption "Enable evince";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
