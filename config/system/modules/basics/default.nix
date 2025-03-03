{ pkgs, lib, inputs, config, ... }:
{
  options = {
    basics.enable = lib.mkEnableOption "Enable basics";
  };

  config = lib.mkIf config.basics.enable {

    # Enable basics packages system-wide
    environment.systemPackages = with pkgs; [
      wget
      htop
      nixpkgs-fmt
    ];

    # Enable zsh
    programs.zsh.enable = true;

    # Set nanorc
    programs.nano = {
      enable = true;
      nanorc = ''
        set tabstospaces
        set tabsize 2
      '';
    };

    # Enable non-free software & experimental features
    nix.settings.experimental-features = ["nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Automatic garbage collection & Nix store optimization
    nix.gc.automatic = true;
    nix.settings.auto-optimise-store = true;

    # Time zone
    time.timeZone = "Europe/Copenhagen";

    # Internationalisation properties.
    i18n.defaultLocale = "en_DK.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };

  };
}
