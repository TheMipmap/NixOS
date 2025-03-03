{ pkgs, lib, config, ... }:
let
  cfg = config.<package_name>;
  dependencies = with pkgs; [ <dependencies> ];

in
{
  options = {
    <package_name> = {
      enable = lib.mkEnableOption "Enable <package_name>";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
