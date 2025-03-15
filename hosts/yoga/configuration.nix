{ config, pkgs, ... }: {
  networking.hostName = "yoga";

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../config/system/default.nix
    ];

  # Desktop/Diplay managers
  gnome = {
    enable = true;
    gdm.enable = false;
  };
  sddm.enable = true;
  hyprland.enable = true;

  # Host-specific modules
  basics.enable = true;
  bluetooth.enable = true;
  gnupg.enable = true;
  grub.enable = true;
  network.enable = true;
  nvidia.enable = true;
  pipewire.enable = true;

  # User Account
  users.users.morten = {
    isNormalUser = true;
    description = "Morten";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.11"; # Yes, I did.

}
