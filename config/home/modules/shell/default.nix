{ pkgs, lib, config, ... }:
let
  cfg = config.shell;
  dependencies = with pkgs; [ zoxide fzf ];
  aliases = {
    # Declare shell aliases
    "q" = "exit";
    "open" = "xdg-open";
    "cd.." = "cd .."; # The bane of my existence
    "nr" = "nixos-rebuild switch --flake ~/NixOS --use-remote-sudo";
  };
    
in
{
  imports = [ ];

  options = {
    shell = {
      enable = lib.mkEnableOption "Enable shell configuration";
      
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
      
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };

    # Bash config (Primarily to make sure my aliases work if i stumble into bash)
    programs.bash = {
      enable = true;
      shellAliases = aliases;
      historySize = 5000;
      historyFile = "$HOME/.bash_history";
    };

    # zsh config
    programs.zsh = {
      enable = true;
      shellAliases = aliases;
      history = {
        save = 15000;
        size = 15000;
        path = "$HOME/.zsh_history";
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
        ignoreAllDups = true;
      };

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "z" "fzf" "colored-man-pages" "sudo" ];
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./themes;
          file = "p10k.zsh";
        }
      ];

      dotDir = ".config/zsh";
      initExtra = ''
        eval "$(zoxide init --cmd cd zsh)"
        bindkey '^f' autosuggest-accept
        bindkey '^k' history-search-backward
        bindkey '^j' history-search-forward
      '';
    };
  };
}
