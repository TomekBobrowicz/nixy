{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
        color = {
          keys = "35";
          output = "75";
        };
        separator = " ➜  ";
      };

      logo = {
        source = ./nixos.png;
        type = "kitty-direct";
        height = 10;
        width = 20;
        padding = {
          top = 2;
          left = 2;
        };
      };

      modules = [
        "break"
        {
          type = "os";
          key = "OS  ";
          keyColor = "32";
        }
        {
          type = "kernel";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "packages";
          key = " ├ 󰏖 ";
          keyColor = "32";
        }
        {
          type = "command";
          key = " ├  ";
          keyColor = "32";
          text = "hourglass";
        }
        {
          type = "shell";
          key = " └  ";
          keyColor = "32";
        }
        "break"
        {
          type = "wm";
          key = "WM   ";
          keyColor = "32";
        }
        {
          type = "wmtheme";
          key = " ├ 󰉼 ";
          keyColor = "32";
        }
        {
          type = "icons";
          key = " ├ 󰀻 ";
          keyColor = "32";
        }
        {
          type = "cursor";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "terminal";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "terminalfont";
          key = " └  ";
          keyColor = "32";
        }
        "break"
        {
          type = "host";
          format = "{5} {1} Type {2}";
          key = "PC   ";
          keyColor = "32";
        }
        {
          type = "cpu";
          format = "{1} ({3}) @ {7} GHz";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "gpu";
          format = "{1} {2} @ {12} GHz";
          key = " ├ 󰢮 ";
          keyColor = "32";
        }
        {
          type = "memory";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "disk";
          key = " ├ 󰋊 ";
          keyColor = "32";
        }
        {
          type = "monitor";
          key = " ├  ";
          keyColor = "32";
        }
        {
          type = "player";
          key = " ├ 󰥠 ";
          keyColor = "32";
        }
        {
          type = "media";
          key = " └ 󰝚 ";
          keyColor = "32";
        }
        "break"
        {
          type = "uptime";
          key = "   Uptime   ";
          keyColor = "32";
        }
      ];
    };
  };
}
