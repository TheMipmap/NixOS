{ pkgs, lib, config, ... }:
let
  cfg = config.remmina;
  dependencies = with pkgs; [ remmina ];

in
{
  options = {
    remmina = {
      enable = lib.mkEnableOption "Enable remmina";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
