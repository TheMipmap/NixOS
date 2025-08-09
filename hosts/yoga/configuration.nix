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
    enable = false;
    gdm.enable = false;
  };
  sddm.enable = true;
  hyprland.enable = true;

  # Host-specific modules
  basics.enable = true;
  bluetooth.enable = true;
  grub.enable = true;
  network.enable = true;
  nvidia = {
    enable = true;
    demos.enable = true;
    hybrid = {
      enable = true;
      amdgpuBusId = "PCI:63:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  pipewire.enable = true;
  tlp.enable = true;
  theme.enable = true;

  # Gaming
  gaming = {
    proton.enable = true;
    steam.enable = true;
    minecraft.enable = true;
  };

  # User Account
  users.users.morten = {
    isNormalUser = true;
    description = "Morten";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.11"; # Yes, I did.

}
