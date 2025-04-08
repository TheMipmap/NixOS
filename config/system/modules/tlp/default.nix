{ pkgs, lib, inputs, config, ... }:
{
  options = {
    tlp.enable = lib.mkEnableOption "Enable tlp";
  };

  config = lib.mkIf config.tlp.enable {
    # Start the TLP service
    services.tlp = {
      enable = true;

      # Configure TLP settings
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        STOP_CHARGE_THRESH_BAT0 = 1; # Lenovo Yoga specific - Activates battery conservation mode
      };
    };
  };
}
