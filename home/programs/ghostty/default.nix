{
  pkgs,
  config,
  ...
}: {
programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    clearDefaultKeybinds = true;
    settings = {
      title = "GhosTTY";
      term = "xterm-256color";
      confirm-close-surface = "false";
      font-family = "Maple Mono NF";
      font-size = 12;
      theme = "Ayu";
      adjust-cell-height = "10%";
      window-theme = "dark";
      window-height = "32";
      window-width = "110";
      background-opacity = "1.00";
      background-blur-radius = "60";
      selection-background = "#2d3f76";
      selection-foreground = "#c8d3f5";
      cursor-style = "bar";
      mouse-hide-while-typing = "true";
      wait-after-command = "false";
      shell-integration = "detect";
      window-save-state = "always";
      gtk-single-instance = "true";
      unfocused-split-opacity = "0.5";
      quick-terminal-position = "center";
      shell-integration-features = "cursor,sudo";
      bold-is-bright = "false";
      keybind = [
        # Copy/Paste
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"

        # Font size control
        "ctrl+shift+plus=increase_font_size:1"
        "ctrl+shift+minus=decrease_font_size:1"
        "ctrl+shift+zero=reset_font_size"

        "alt+s>r=reload_config"
        "alt+s>x=close_surface"

        "alt+s>n=new_window"

        # tabs
        "alt+s>c=new_tab"
        "alt+s>shift+l=next_tab"
        "alt+s>shift+h=previous_tab"
        "alt+s>comma=move_tab:-1"
        "alt+s>period=move_tab:1"

        # quick tab switch
        "alt+s>1=goto_tab:1"
        "alt+s>2=goto_tab:2"
        "alt+s>3=goto_tab:3"
        "alt+s>4=goto_tab:4"
        "alt+s>5=goto_tab:5"
        "alt+s>6=goto_tab:6"
        "alt+s>7=goto_tab:7"
        "alt+s>8=goto_tab:8"
        "alt+s>9=goto_tab:9"

        # split
        "alt+s>\\=new_split:right"
        "alt+s>-=new_split:down"

        "alt+s>j=goto_split:bottom"
        "alt+s>k=goto_split:top"
        "alt+s>h=goto_split:left"
        "alt+s>l=goto_split:right"

        "alt+s>z=toggle_split_zoom"

        "alt+s>e=equalize_splits"
      ];
    };
  };
}