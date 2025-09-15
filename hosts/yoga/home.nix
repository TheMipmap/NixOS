{ inputs, config, pkgs, ... }:

{
  imports = [
    ../../config/home/default.nix
  ];

  home = {
    username = "morten";
    homeDirectory = "/home/morten";
    stateVersion = "25.05";
  };

  ##--- Hyprland ---##
  hyprland = {
    enable = true;
    kb_layout = "dk,us";
  };

  ##--- Applications ---###
  chromium.enable = false;
  discord.enable = true;
  element.enable = true;
  evince.enable = true;
  firefox.enable = true;
  gimp.enable = true;
  loupe.enable = true;
  onedrive.enable = true;
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
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = null; # "${config.home.homeDirectory}/Music";
    pictures = null; # "${config.home.homeDirectory}/Pictures";
    publicShare = null; # "${config.home.homeDirectory}/Public";
    templates = null; # "${config.home.homeDirectory}/Templates";
    videos = null; # "${config.home.homeDirectory}/Videos";
  };

  programs.home-manager.enable = true;
}
