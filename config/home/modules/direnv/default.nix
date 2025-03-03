{ pkgs, lib, config, ... }:
let
  cfg = config.direnv;
  dependencies = with pkgs; [ direnv ];

in
{
  options = {
    direnv = {
      enable = lib.mkEnableOption "Enable direnv";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };

    # Direnv
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

  };
}
