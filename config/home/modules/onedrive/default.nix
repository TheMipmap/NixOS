{ pkgs, lib, config, ... }:
let
  cfg = config.onedrive;
  dependencies = with pkgs; [ onedrive ];

in
{
  options = {
    onedrive = {
      enable = lib.mkEnableOption "Enable onedrive";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };

    # OBS: Manually run 'onedrive' first time to authorize client.
    # Controlled using systemd in user-space.
  };
}
