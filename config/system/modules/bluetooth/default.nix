{ pkgs, lib, inputs, config, ... }:
{
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false; # Whether to power up the default Bluetooth controller on boot.
    };
  };
}
