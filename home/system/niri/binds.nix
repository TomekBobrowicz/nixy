{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
  in {
    "XF86AudioPlay".action = playerctl "play-pause";
    "XF86AudioStop".action = playerctl "pause";
    "XF86AudioPrev".action = playerctl "previous";
    "XF86AudioNext".action = playerctl "next";

    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "mute"
      ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "micmute"
      ];
    };

    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "increment"
        "5"
      ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "decrement"
        "5"
      ];
    };

    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "brightness"
        "increment"
        "5"
        "amdgpu_bl1"
      ];
    };

    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "brightness"
        "decrement"
        "5"
        "amdgpu_bl1"
      ];
    };

    "Super+Alt+L".action = spawn [
      "dms"
      "ipc"
      "call"
      "lock"
      "lock"
    ];

    "Mod+V".action = spawn [
      "dms"
      "ipc"
      "call"
      "clipboard"
      "toggle"
    ];

    "Mod+P".action = spawn [
      "dms"
      "ipc"
      "call"
      "notepad"
      "toggle"
    ];

    "Mod+U".action = spawn [
      "dms"
      "ipc"
      "call"
      "settings"
      "toggle"
    ];

      "Mod+X".action = spawn [
      "dms"
      "ipc"
      "call"
      "powermenu"
      "toggle"
    ];

      "Mod+Shift+C".action = spawn [
      "dms"
      "ipc"
      "call"
      "control-center"
      "toggle"
    ];

    "Mod+M".action = spawn [
      "dms"
      "ipc"
      "call"
      "processlist"
      "toggle"
    ];

    "Mod+Space".action = spawn [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggle"
    ];

    "Mod+D".action = spawn [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggle"
    ];

    "Print".action.screenshot-screen = {write-to-disk = true;};
    "Mod+Shift+Alt+S".action = screenshot-window;
    "Mod+Shift+S".action.screenshot = {show-pointer = false;};
    "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";

    "Mod+A".action = toggle-overview;
    "Mod+Q".action = close-window;
    "Mod+S".action = switch-preset-column-width;
    "Mod+F".action = maximize-column;
    "Mod+L".action = spawn ["dms" "ipc" "call" "lock" "lock"];
    "Mod+W".action = spawn ["waypaper"];
    "Mod+E".action = spawn ["${pkgs.xfce.thunar}/bin/thunar"];
    "Mod+B".action = spawn ["google-chrome-stable"];

    "Mod+WheelScrollDown".action = focus-workspace-down;
    "Mod+WheelScrollUp".action = focus-workspace-up;
    
    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;
    "Mod+0".action = focus-workspace 10;

    /*"Mod+Shift+1".action = move-column-to-workspace 1;
    "Mod+Shift+2".action = move-column-to-workspace 2;
    "Mod+Shift+3".action = move-column-to-workspace 3;
    "Mod+Shift+4".action = move-column-to-workspace 4;
    "Mod+Shift+5".action = move-column-to-workspace 5;
    "Mod+Shift+6".action = move-column-to-workspace 6;
    "Mod+Shift+7".action = move-column-to-workspace 7;
    "Mod+Shift+8".action = move-column-to-workspace 8;
    "Mod+Shift+9".action = move-column-to-workspace 9;
    "Mod+Shift+0".action = move-column-to-workspace 10;*/

    # "Mod+Shift+F".action = fullscreen-window;
    "Mod+Shift+F".action = expand-column-to-available-width;
    "Mod+T".action = toggle-window-floating;

    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    "Mod+C".action = center-visible-columns;
    "Mod+Tab".action = switch-focus-between-floating-and-tiling;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;

    "Mod+Shift+Left".action = move-column-left;
    "Mod+Shift+Right".action = move-column-right;
    "Mod+Shift+Up".action = move-column-to-workspace-up;
    "Mod+Shift+Down".action = move-column-to-workspace-down;

    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;

    "Mod+Escape"  = {
      allow-inhibiting = false;
      action = toggle-keyboard-shortcuts-inhibit;
  };
};
}
