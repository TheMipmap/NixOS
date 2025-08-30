# Lutris is a video game preservation platform that you can use to play 
# or emulate pretty much any game you want, including games from Epic Games.
# https://wiki.nixos.org/wiki/Lutris

{ pkgs, lib, config, ... }:
let
  cfg = config.gaming.lutris;
in
{

  options.gaming.lutris = {
    enable = lib.mkEnableOption "enable lutris";
  };

  config = lib.mkIf cfg.enable {

    # Assertion to ensure NVIDIA driver is enabled
    assertions = [
      {
        assertion = config.nvidia.enable == true;
        message = "The 'nvidia' video driver module must be enabled for gaming.";
      }
    ];

    # Install lutris
    environment.systemPackages = with pkgs; [
      lutris
    ];

    # If any games are unable to run due to missing dependencies, 
    # they can be installed using the following methods.
    # environment.systemPackages = with pkgs; [
    #   (lutris.override {
    #     extraLibraries = pkgs: [
    #       # List library dependencies here
    #     ];
    #     extraPkgs = pkgs: [
    #       # List package dependencies here
    #     ];
    #   })
    # ];

    # Esync compatibility
    systemd.extraConfig = "DefaultLimitNOFILE=524288";
    security.pam.loginLimits = [{
      domain = "yourusername";
      type = "hard";
      item = "nofile";
      value = "524288";
    }];

  };

}
