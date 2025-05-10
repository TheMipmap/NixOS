{ pkgs, lib, config, ... }:
let
  cfg = config.chromium;
  dependencies = with pkgs; [ ];

in
{
  options = {
    chromium = {
      enable = lib.mkEnableOption "Enable chromium";
    };
  };

  config = lib.mkIf
    cfg.enable
    {
      home = {
        packages = dependencies;
      };

      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;

        # Add extensions by ID
        extensions = [
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
        ];
      };
    };
}
