{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/ghostty
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/git/signing.nix
    ../../home/programs/spicetify
    ../../home/programs/lazygit
    ../../home/programs/discord
    ../../home/programs/media

    # Scripts
    ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    #../../home/system/hyprland
    ../../home/system/hypridle
    ../../home/system/hyprlock
    ../../home/system/hyprpanel
    ../../home/system/hyprpaper
    ../../home/system/wofi
    ../../home/system/zathura
    ../../home/system/mime
    ../../home/system/udiskie
    ../../home/system/clipman
    ../../home/system/niri

    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri

    # ./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      bitwarden # Password manager
      blanket # White-noise app
      obsidian # Note taking app
      # planify # Todolists
      gnome-calendar # Calendar
      nautilus  # File manager
      textpieces # Manipulate texts
      curtail # Compress images
      resources
      gnome-clocks
      gnome-text-editor
      figma-linux
      google-chrome # Web browser
      waypaper # Wallpaper manager
      hyprpaper # Wallpaper manager
      libreoffice # Office suite
      vesktop # Discord desktop app

      # Dev
      go
      bun
      #nodejs
      python3
      jq
      just
      pnpm
      air

      # Utils
      zip
      unzip
      optipng
      jpegoptim
      pfetch
      btop
      fastfetch

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix

      # Backup
      #brave
      vscode
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = {source = ./profile_picture.png;};

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  programs.dankMaterialShell.enable = true;
  #programs.niri.enable = true;
}
