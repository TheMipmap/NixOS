{ inputs, config, pkgs, ... }:

{
  imports = [
    ../../config/home/default.nix
  ];

  home = {
    username = "morten";
    homeDirectory = "/home/morten";
    stateVersion = "24.11";
  };

  ##--- Hardware ---##
  #hardware = {
  #  touchpad.enable = true;
  #};

  ##--- Hyprland ---##
  hyprland.enable = true;

  ##--- Theme ---##
  #theme = {
  #  enable = true;
  #  colorscheme = "catppuccin-mocha";
  #  wallpaper = "biking_sunset.jpg";
  #};

  ##--- Applications ---###
  #calculator.enable = true;
  alacritty.enable = true;
  discord.enable = true;
  firefox.enable = true;
  foot.enable = true;
  ghostty.enable = true;
  onedrive.enable = true;
  vscode.enable = true;

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
