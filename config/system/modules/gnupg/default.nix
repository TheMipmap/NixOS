{ pkgs, lib, inputs, config, ... }:
{
  options = {
    gnupg.enable = lib.mkEnableOption "Enable gnupg";
  };

  config = lib.mkIf config.gnupg.enable {
    # Enable support for SSH in Hyprland
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
