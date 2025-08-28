{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  options = { 
    hyprland.kb_layout = lib.mkOption {
          type = lib.types.str;
          description = "Keyboard layout (e.g. 'us', 'dk')";
          default = "dk";
    };
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      input = {
        "kb_layout" = config.hyprland.kb_layout;
        "kb_variant" = "";
        "kb_model" = "";
        "kb_options" = "";
        "kb_rules" = "";

        "follow_mouse" = "1";
        "sensitivity" = "0"; # -1.0 - 1.0, 0 mean no modification.
        
        touchpad = {
          "natural_scroll" = "true";
        };
      };
    };
  };
}
