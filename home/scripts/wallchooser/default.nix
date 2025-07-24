{
  config,
  pkgs,
  ...
}: let
  # Define your wallpaper directory
  myWallpapersDir = "/home/buber/Pictures/Wallpapers"; # Adjust username and path

  # Define the random wallpaper script
  wallpaperRandomizerScript = pkgs.writeShellScriptBin "wallchooser" ''

    WALLPAPER_DIR="${myWallpapersDir}"

    if [ ! -d "$WALLPAPER_DIR" ]; then
      echo "Wallpaper directory not found: $WALLPAPER_DIR" >&2
      exit 1
    fi

    # Select ONE random wallpaper from the directory
    # We include common image formats. Add or remove as needed.
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.webp" \) -print0 | shuf -n 1 -z | xargs -0)

    if [ -n "$WALLPAPER" ]; then
      # Unload all currently loaded wallpapers to free memory (optional but good practice)
      hyprctl hyprpaper unload all

      # Preload the chosen wallpaper
      hyprctl hyprpaper preload "$WALLPAPER"

      # Set the wallpaper for ALL monitors.
      # The empty string before the comma tells hyprpaper to apply to all monitors.
      hyprctl hyprpaper wallpaper ",$WALLPAPER"
      echo "Set wallpaper for all monitors: $WALLPAPER"
    else
      echo "No wallpaper found in $WALLPAPER_DIR." >&2
    fi
  '';
in {
  # ... (previous hyprland and hyprpaper enabling)

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Execute the script on Hyprland startup
      exec-once = [
        "${wallpaperRandomizerScript}/bin/wallchooser"
      ];

      # Optional: Bind a key to change the wallpaper
      # Replace SUPER_L with your preferred modifier key
      # Replace W with your desired key
      bind = [
        "SUPER_L Shift, W, exec, ${wallpaperRandomizerScript}/bin/wallchooser"
      ];
    };
  };
  systemd.user.timers.wallchooser = {
    Unit = {
      Description = "Run random wallpaper script every 30 minutes";
    };
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "5min"; # Adjust interval as needed
    };
    Install = {
      WantedBy = ["timers.target"];
    };
  };
  # Make sure the `jq` package is available for the script
  home.packages = with pkgs; [
    jq
    coreutils # for shuf
    findutils # for find
    wallpaperRandomizerScript
  ];

  # ...
}
