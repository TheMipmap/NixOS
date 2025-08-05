# Steam launch options:
# - Optimize system and game        -> "gamemoderun %command%"
# - Display system resource monitor -> "mangohud %command%"
# - Fix potential scaling issues    -> "gamescope %command%"

{ pkgs, lib, config, ... }:
let
  cfg = config.gaming.steam;
in
{

  options.gaming.steam = {
    enable = lib.mkEnableOption "enable steam";
  };

  config = lib.mkIf cfg.enable {

    # Assertion to ensure NVIDIA driver is enabled
    assertions = [
      {
        assertion = config.nvidia.enable == true;
        message = "The 'nvidia' video driver module must be enabled for gaming.";
      }
    ];

    # Steam setup
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true; # Vimjoyer: Helps with scaling problems
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Enable gamemode daemon to improve gaming performance
    # - Temporarily applies optimizations to the system and game
    programs.gamemode.enable = true;

    # Install extra packages
    environment.systemPackages = with pkgs; [
      mangohud # System monitoring program
    ];

  };

}
