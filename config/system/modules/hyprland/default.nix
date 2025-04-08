{ pkgs, lib, inputs, config, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Speedup electron apps
    };

    # Enable egl-wayland when using nvidia
    environment.systemPackages = with pkgs; (if (config.nvidia.enable == true) then [ egl-wayland wayland-utils kdePackages.wayland-protocols ] else [ ]);
  };
}
