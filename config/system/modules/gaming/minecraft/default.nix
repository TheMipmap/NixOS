{ pkgs, lib, config, ... }:
let
  cfg = config.gaming.minecraft;
in
{

  options.gaming.minecraft = {
    enable = lib.mkEnableOption "enable minecraft";
  };

  config = lib.mkIf cfg.enable {

    # Install packages
    environment.systemPackages = with pkgs; [
      prismlauncher # https://wiki.nixos.org/wiki/Prism_Launcher
    ];

  };

}
