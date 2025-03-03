{ pkgs, lib, config, ... }:
let
  cfg = config.git;
  dependencies = with pkgs; [ git ];

in
{
  options = {
    git = {
      enable = lib.mkEnableOption "Enables git";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
    
    # Define git user
    programs.git = {
      enable = true;
      userName = "Morten Stephansen";
      userEmail = "morten-ks@hotmail.com";
      extraConfig = {
          init.defaultBranch = "main";
      };
    };
  };
}
