{ pkgs, lib, config, ... }:
let
  cfg = config.vscode;
  dependencies = with pkgs; [ vscode ];

in
{
  options = {
    vscode = {
      enable = lib.mkEnableOption "Enable vscode";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
