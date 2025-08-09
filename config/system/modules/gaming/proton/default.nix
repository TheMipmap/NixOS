{ pkgs, lib, config, ... }:
let
  cfg = config.gaming.proton;
in
{

  options.gaming.proton = {
    enable = lib.mkEnableOption "enable proton GE";
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      protonup-qt # GUI for installing custom Proton versions like GE_Proton
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
    };

  };

}
