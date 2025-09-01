{ pkgs, lib, config, ... }:
let
  cfg = config.gaming.heroic;
in
{

  options.gaming.heroic = {
    enable = lib.mkEnableOption "enable heroic";
  };

  config = lib.mkIf cfg.enable {

    # Assertion to ensure NVIDIA driver is enabled
    assertions = [
      {
        assertion = config.nvidia.enable == true;
        message = "The 'nvidia' video driver module must be enabled for gaming.";
      }
    ];

    # Install heroic
    environment.systemPackages = with pkgs; [
      heroic
    ];

    # If any games are unable to run due to missing dependencies, 
    # they can be installed using the following methods.
    # environment.systemPackages = with pkgs; [
    #   (heroic.override {
    #     extraLibraries = pkgs: [
    #       # List library dependencies here
    #     ];
    #     extraPkgs = pkgs: [
    #       # List package dependencies here
    #     ];
    #   })
    # ];
  };

}
