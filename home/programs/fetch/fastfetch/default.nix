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
        height = 7;
        width = 16;
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
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = " ├  ";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = " ├ 󰏖 ";
          keyColor = "yellow";
        }
        {
          type = "command";
          key = " ├  ";
          keyColor = "yellow";
          text = "hourglass";
        }
        {
          type = "shell";
          key = " └  ";
          keyColor = "yellow";
        }
        "break"
        {
          type = "wm";
          key = "WM   ";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = " ├ 󰉼 ";
          keyColor = "blue";
        }
        {
          type = "icons";
          key = " ├ 󰀻 ";
          keyColor = "blue";
        }
        {
          type = "cursor";
          key = " ├  ";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = " ├  ";
          keyColor = "blue";
        }
        {
          type = "terminalfont";
          key = " └  ";
          keyColor = "blue";
        }
        "break"
        {
          type = "host";
          format = "{5} {1} Type {2}";
          key = "PC   ";
          keyColor = "green";
        }
        {
          type = "cpu";
          format = "{1} ({3}) @ {7} GHz";
          key = " ├  ";
          keyColor = "green";
        }
        {
          type = "gpu";
          format = "{1} {2} @ {12} GHz";
          key = " ├ 󰢮 ";
          keyColor = "green";
        }
        {
          type = "memory";
          key = " ├  ";
          keyColor = "green";
        }
        {
          type = "disk";
          key = " ├ 󰋊 ";
          keyColor = "green";
        }
        {
          type = "monitor";
          key = " └  ";
          keyColor = "green";
        }
        "break"
        {
          type = "uptime";
          key = "   Uptime   ";
          keyColor = "magenta";
        }
      ];
    };
  };
}
