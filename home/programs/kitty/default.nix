{
  pkgs,
  lib,
  ...
}:
# Kitty is a fast, featureful, GPU based terminal emulator
{
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+tab" = "new_tab";
      "ctrl+j" = ''kitten pass_keys.py bottom ctrl+j'';
      "ctrl+k" = ''kitten pass_keys.py top    ctrl+k'';
      "ctrl+h" = ''kitten pass_keys.py left   ctrl+h'';
      "ctrl+l" = ''kitten pass_keys.py right  ctrl+l'';
    };
    settings = {
      scrollback_lines = 10000;
      initial_window_width = 1200;
      initial_window_height = 600;
      update_check_interval = 0;
      enable_audio_bell = false;
      confirm_os_window_close = "0";
      remember_window_size = "no";
      disable_ligatures = "never";
      url_style = "curly";
      copy_on_select = "clipboard";
      cursor_shape = "Underline";
      cursor_underline_thickness = 3;
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      window_padding_width = 10;
      open_url_with = "default";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/mykitty";
      background_opacity = lib.mkForce 0.9;
    };
    extraConfig = ''
      # Enable kitty's own key handling
        # vim:ft=kitty

        ## name:     Catppuccin Kitty Mocha
        ## author:   Catppuccin Org
        ## license:  MIT
        ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf
        ## blurb:    Soothing pastel theme for the high-spirited!



        # The basic colors
        foreground              #cdd6f4
        background              #1e1e2e
        selection_foreground    #1e1e2e
        selection_background    #f5e0dc

        # Cursor colors
        cursor                  #f5e0dc
        cursor_text_color       #1e1e2e

        # URL underline color when hovering with mouse
        url_color               #f5e0dc

        # Kitty window border colors
        active_border_color     #b4befe
        inactive_border_color   #6c7086
        bell_border_color       #f9e2af

        # OS Window titlebar colors
        wayland_titlebar_color system
        macos_titlebar_color system

        # Tab bar colors
        active_tab_foreground   #11111b
        active_tab_background   #cba6f7
        inactive_tab_foreground #cdd6f4
        inactive_tab_background #181825
        tab_bar_background      #11111b

        # Colors for marks (marked text in the terminal)
        mark1_foreground #1e1e2e
        mark1_background #b4befe
        mark2_foreground #1e1e2e
        mark2_background #cba6f7
        mark3_foreground #1e1e2e
        mark3_background #74c7ec

        # The 16 terminal colors

        # black
        color0 #45475a
        color8 #585b70

        # red
        color1 #f38ba8
        color9 #f38ba8

        # green
        color2  #a6e3a1
        color10 #a6e3a1

        # yellow
        color3  #f9e2af
        color11 #f9e2af

        # blue
        color4  #89b4fa
        color12 #89b4fa

        # magenta
        color5  #f5c2e7
        color13 #f5c2e7

        # cyan
        color6  #94e2d5
        color14 #94e2d5

        # white
        color7  #bac2de
        color15 #a6adc8
    '';
  };

  xdg.configFile = {
    "kitty/pass_keys.py".text = ''
      import re

      from kittens.tui.handler import result_handler
      from kitty.key_encoding import KeyEvent, parse_shortcut


      def is_window_vim(window, vim_id):
          fp = window.child.foreground_processes
          return any(re.search(vim_id, p['cmdline'][0] if len(p['cmdline']) else "", re.I) for p in fp)


      def encode_key_mapping(window, key_mapping):
          mods, key = parse_shortcut(key_mapping)
          event = KeyEvent(
              mods=mods,
              key=key,
              shift=bool(mods & 1),
              alt=bool(mods & 2),
              ctrl=bool(mods & 4),
              super=bool(mods & 8),
              hyper=bool(mods & 16),
              meta=bool(mods & 32),
          ).as_window_system_event()

          return window.encoded_key(event)


      def main():
          pass


      @result_handler(no_ui=True)
      def handle_result(args, result, target_window_id, boss):
          direction = args[1]
          key_mapping = args[2]
          vim_id = args[3] if len(args) > 3 else "n?vim"

          window = boss.window_id_map.get(target_window_id)

          if window is None:
              return
          if is_window_vim(window, vim_id):
              for keymap in key_mapping.split(">"):
                  encoded = encode_key_mapping(window, keymap)
                  window.write_to_child(encoded)
          else:
              boss.active_tab.neighboring_window(direction)
    '';
    "kitty/neighboring_window.py".text = ''
      def main():
          pass


      def handle_result(args, result, target_window_id, boss):
          return boss.active_tab.current_layout.name


      handle_result.no_ui = True
    '';
  };
}
