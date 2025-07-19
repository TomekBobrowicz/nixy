# Discord is a popular chat application.
{inputs, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    config = {
      useQuickCss = true; # use out quickCSS
      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
      ];
      frameless = true;
    };
  };
  stylix.targets.nixcord.enable = false;
}
