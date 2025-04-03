{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.theme;
in {
  options = {
    theme.enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.theme.enable {
    fonts.fontDir.enable = true;

    stylix = {
      enable = lib.mkDefault true;
      autoEnable = true;
      image = ../../../../resources/sunrise_new.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      homeManagerIntegration = {
        autoImport = true;
        followSystem = true;
      };

      targets = {
        console.enable = true;
        gtk.enable = true;
        nixos-icons.enable = true;
      };

      cursor = {
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
        size = 24;
      };

      fonts = {
        serif = {
          name = "IBM Plex Serif";
          package = pkgs.ibm-plex;
        };
        sansSerif = {
          name = "IMB Plex Sans";
          package = pkgs.ibm-plex;
        };
        monospace = {
          name = "IBM Plex Mono";
          package = pkgs.ibm-plex;
        };
        emoji = {
          name = "Twemoji";
          package = pkgs.twitter-color-emoji;
        };
        sizes = {
          applications = 12;
          desktop = 10;
          popups = 10;
          terminal = 12;
        };
      };
    };
  };
}