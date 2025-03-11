{ pkgs, lib, inputs, config, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      nvidiaPatches = true; # TODO: Move into a mkMerge/mkIf that checks for nvidia.enable      
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    
    # Add kitty until I've replaced it in the hyprland config
    environment.systemPackages = [ kitty ];

    # TODO: Try Enabling egl-wayland when using nvidia
    #environment.systemPackages = with pkgs; (if (config.nvidia.enable == true) then [egl-wayland] else []);
  };
}
