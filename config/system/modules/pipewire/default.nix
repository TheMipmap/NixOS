{ pkgs, lib, inputs, config, ... }:
{
  options = {
    pipewire.enable = lib.mkEnableOption "Enable pipewire";
  };

  config = lib.mkIf config.pipewire.enable {
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
