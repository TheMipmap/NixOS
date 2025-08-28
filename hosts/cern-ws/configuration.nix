{ config, pkgs, ... }: {
  networking.hostName = "cern-ws";

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../config/system/default.nix
    ];

  # Desktop/Diplay managers
  sddm.enable = true;
  hyprland.enable = true;

  # Host-specific modules
  basics.enable = true;
  bluetooth.enable = true;
  grub.enable = true;
  network.enable = true;
  pipewire.enable = true;
  theme.enable = true;

  # User Account
  users.users.mostepha = {
    isNormalUser = true;
    description = "Morten";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Decrypt swap partition on boot
  boot.initrd.luks.devices."luks-a3f1a42f-dfe7-424b-93d7-b43f6a47af07".device = "/dev/disk/by-uuid/a3f1a42f-dfe7-424b-93d7-b43f6a47af07";

  system.stateVersion = "25.05";
}
