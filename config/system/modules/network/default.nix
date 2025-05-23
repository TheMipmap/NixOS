{ pkgs, lib, inputs, config, ... }:
{
  options = {
    network.enable = lib.mkEnableOption "Enable network";
  };

  config = lib.mkIf config.network.enable {

    environment.systemPackages = [
      pkgs.networkmanagerapplet
    ];

    # Enable networking
    networking.networkmanager.enable = true;

    # Ensure wireguard can be used
    networking.firewall.checkReversePath = false;

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
