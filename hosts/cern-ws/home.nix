{ inputs, config, pkgs, ... }:

{
  imports = [
    ../../config/home/default.nix
  ];

  home = {
    username = "mostepha";
    homeDirectory = "/home/mostepha";
    stateVersion = "25.05";
  };

  ##--- Hyprland ---##
  hyprland = {
    enable = true;
    kb_layout = "us,dk";
  };
  hyprlock.timeout = 180;

  ##--- Applications ---###
  chromium.enable = true;
  discord.enable = true;
  element.enable = true;
  evince.enable = true;
  firefox = {
    enable = true;
    defaultProfile = "CERN";
  };
  gimp.enable = true;
  loupe.enable = true;
  onedrive.enable = false;
  remmina.enable = true;
  vscode.enable = true;

  ##--- Terminal Emulators ---##
  foot.enable = true;
  ghostty.enable = true;
  wezterm.enable = true;

  ##--- Other ---##
  direnv.enable = true;
  git.enable = true;
  gnupg.enable = true;
  shell.enable = true;
  theme.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null; # "${config.home.homeDirectory}/Desktop";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    pictures = "${config.home.homeDirectory}/Pictures";
    music = null; # "${config.home.homeDirectory}/Music";
    publicShare = null; # "${config.home.homeDirectory}/Public";
    templates = null; # "${config.home.homeDirectory}/Templates";
    videos = null; # "${config.home.homeDirectory}/Videos";
  };

  programs.home-manager.enable = true;
}
