{ ... }: {
  
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
    
    bindls = [
      "Shift_L&Super_L&XF86TouchpadOff, , exec, $terminal"
    ];

    bindd = [
      ##--- General Window Controls ---##
      "$mainMod, Q, Kill Active Window, killactive, "
      "$mainMod, O, Toggle Fullscreen Window, fullscreen,"
      "$mainMod, M, Logout Of Hyprland, exit, "
      "$mainMod, T, Start Terminal, exec, $terminal"
      "$mainMod, F, Start File Manager, exec, $fileManager"
      "$mainMod, Space, Start Menu, exec, pkill rofi || $menu"
      
      ##--- Workspace Focus ---##
      "$mainMod, 1, Focus Workspace 1, workspace, 1"
      "$mainMod, 2, Focus Workspace 2, workspace, 2"
      "$mainMod, 3, Focus Workspace 3, workspace, 3"
      "$mainMod, 4, Focus Workspace 4, workspace, 4"
      "$mainMod, 5, Focus Workspace 5, workspace, 5"
      "$mainMod, 6, Focus Workspace 6, workspace, 6"
      "$mainMod, 7, Focus Workspace 7, workspace, 7"
      "$mainMod, 8, Focus Workspace 8, workspace, 8"
      "$mainMod, 9, Focus Workspace 9, workspace, 9"
      "$mainMod, 0, Focus Workspace 10, workspace, 10"
      "$mainMod, BackSpace, Focus Most Recent Workspace, workspace, previous"

      ##--- Move Windows Between Workspaces ---##
      "$mainMod SHIFT, 1, Move Window to Workspace 1, movetoworkspace, 0"
      "$mainMod SHIFT, 2, Move Window to Workspace 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, Move Window to Workspace 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, Move Window to Workspace 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, Move Window to Workspace 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, Move Window to Workspace 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, Move Window to Workspace 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, Move Window to Workspace 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, Move Window to Workspace 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, Move Window to Workspace 10, movetoworkspace, 10"
      "$mainMod SHIFT, BackSpace, Move Window to Recent Workspace, movetoworkspace, previous"

      ##--- Move Focus With Arrows ---##
      "$mainMod, left, Move Focus Left, movefocus, l"
      "$mainMod, right, Move Focus Right, movefocus, r"
      "$mainMod, up, Move Focus Up, movefocus, u"
      "$mainMod, down, Move Focus Down, movefocus, d"

      ",XF86AudioRaiseVolume, , exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, , exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, , exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];
    
    bindel = [
      ##--- Set multimedia/brightness keys ---#
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];
  };
}
