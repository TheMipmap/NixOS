{ pkgs, lib, inputs, config, ... }:
{
  options = {
    gnome.enable = lib.mkEnableOption "Enable GNOME Desktop Manager";
    gnome.gdm.enable = lib.mkEnableOption "Enable GDM Display Manager";
  };

  config = lib.mkIf config.gnome.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.desktopManager.gnome.enable = true;

    # Conditionally enable GDM depending gnome.gdm.enable
    services.xserver.displayManager.gdm.enable = lib.mkIf config.gnome.gdm.enable true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "dk";
      variant = "";
    };

  };
}
