{ pkgs, lib, inputs, config, ... }:
{
  options = {
    sddm.enable = lib.mkEnableOption "Enable SDDM DM";
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm; # qt6 sddm version
      enableHidpi = true; # TODO: Make part of monitor config
      theme = "catppuccin-mocha";
    };

    environment.systemPackages = [(
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font  = "Noto Sans";
        fontSize = "9";
        background = "../../../../resources/$(config.theme.wallpaper)";
        loginBackground = true;
      }
    )];
  };
}
