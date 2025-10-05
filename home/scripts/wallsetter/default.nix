{
  pkgs,
  config,
  lib,
  ...
}: let
  # --- 1. Define your wallpaper directory ---
  # Option A: Nix-managed wallpapers (recommended)
  # This path is relative to the *Nix file* (e.g., home.nix) where this code resides.
  # So, if home.nix is in /home/user/nixos-config/, this points to /home/user/nixos-config/wallpapers/
  #wallpaperSourceDir = builtins.toString (./wallpapers);
  # Option B: User-managed wallpapers (e.g., in your Pictures folder)
  # Uncomment the line below and comment out Option A if you prefer this.
  wallpaperSourceDir = "$HOME/Pictures/Wallpapers";

  # --- 2. Define the script to pick and set a random wallpaper ---
  # This script will be built into your user's path by home-manager
  randomSwwwWallpaperScript = pkgs.writeShellScriptBin "wallsetter" ''
    #!/usr/bin/env bash

    ${pkgs.swww}/bin/swww kill

    # --- Script Configuration (can also be passed as arguments, but defined here for simplicity) ---
    WALLPAPER_DIR="${wallpaperSourceDir}"
    TRANSITION_TYPE="wipe"        # e.g., "wipe", "grow", "fade", "outer", "simple", "random"
    TRANSITION_DURATION="300"     # Milliseconds
    TRANSITION_FPS="60"           # Frames per second

    # Ensure the directory exists
    if [ ! -d "$WALLPAPER_DIR" ]; then
        echo "Error: Wallpaper directory not found at $WALLPAPER_DIR" >&2
        exit 1
    fi

    # Find a random image file (jpg, png, webp, jpeg, jxl) in the directory
    # We explicitly use full paths to binaries from pkgs to ensure robustness in Nix
    RANDOM_WALLPAPER=$(${pkgs.findutils}/bin/find "$WALLPAPER_DIR" -type f \( \
      -name "*.jpg" -o \
      -name "*.jpeg" -o \
      -name "*.png" -o \
      -name "*.webp" -o \
      -name "*.jxl" \
    \) | ${pkgs.coreutils}/bin/shuf -n 1)

    # Check if a wallpaper was found
    if [ -z "$RANDOM_WALLPAPER" ]; then
        echo "Error: No wallpaper files found in $WALLPAPER_DIR" >&2
        exit 1
    fi

    # Set the wallpaper using swww img
    ${pkgs.swww}/bin/swww-daemon & ${pkgs.swww}/bin/swww clear-cache
    ${pkgs.swww}/bin/swww img "$RANDOM_WALLPAPER"
      

    echo "Set wallpaper: $RANDOM_WALLPAPER with transition type: $TRANSITION_TYPE"
  '';
in {
  # --- 3. Enable the swww service ---
  # This ensures the swww-daemon is running when you log in.
  services.swww = {
    enable = true;
    # If you want swww to automatically set a default wallpaper on startup
    # (before your script runs), you can configure it here.
    # Otherwise, your script will handle the initial wallpaper.
    # defaultWallpaper = {
    #   path = "${wallpaperSourceDir}/default.jpg"; # Example default
    #   transition = "fade";
    # };
  };

  # --- 4. Add the script and its dependencies to your user's environment ---
  home.packages = with pkgs; [
    randomSwwwWallpaperScript # Makes the script available in your $PATH
    swww # Ensure swww cli is available
    findutils # For `find`
    gnugrep # For `grep` (though not used directly in this script, good for others)
    gawk # For `awk` (same as grep)
    coreutils # For `shuf`
  ];

  # --- 5. Integrate into Hyprland (assuming you manage Hyprland with home-manager) ---
  wayland.windowManager.hyprland.settings = {
    # Start swww daemon (redundant with services.swww.enable but harmless, good for clarity)
    # The 'services.swww.enable' already ensures this.
    # exec-once = [ "swww init" ];

    # Run the random wallpaper script on Hyprland startup
    # This sets your initial wallpaper when Hyprland launches.
    exec-once = [
      "${randomSwwwWallpaperScript}/bin/wallsetter"
    ];

    # Example keybind to change wallpaper on demand (e.g., Super + W)
    bind = [
      "SUPER Shift, W, exec, ${randomSwwwWallpaperScript}/bin/wallsetter"
    ];
  };

  # --- 6. (Optional) Set up a Systemd User Timer for Periodic Changes ---
  systemd.user.services.wallsetter = {
    Unit = {
      Description = "Set random wallpaper with swww";
    };
    Service = {
      Type = "oneshot";
      # Referencing the script via its Nix store path
      ExecStart = "${randomSwwwWallpaperScript}/bin/wallsetter";
    };
    Install = {
      WantedBy = ["timers.target"];
    };
  };

  systemd.user.timers.wallsetter = {
    Unit = {
      Description = "Run random swww wallpaper script periodically";
    };
    Timer = {
      OnBootSec = "1min"; # Run 1 minute after boot
      OnUnitActiveSec = "30min"; # Run 30 minutes after the last successful run
      # Persistent = true;        # Uncomment if you want the timer to fire even if the system was off
    };
    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
