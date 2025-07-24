# Hyprpaper is used to set the wallpaper on the system
{
  lib,
  config,
  ...
}: {
  # The wallpaper is set by stylix
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      #preload = "/home/buber/Pictures/Wallpapers/blank.png";
      #wallpaper = ",/home/buber/Pictures/Wallpapers/blank.png";
    };
  };
  systemd.user.services.hyprpaper.Unit.After =
    lib.mkForce "graphical-session.target";
}
