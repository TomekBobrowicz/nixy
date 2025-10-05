{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.niri = {
    enable = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      prettyName = "Niri";
      comment = "Niri compositor managed by UWSM";
      binPath = pkgs.writeShellScript "niri" ''
        ${lib.getExe config.programs.niri.package} --session
      '';
    };
  };
}
