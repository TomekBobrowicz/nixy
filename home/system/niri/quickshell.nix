{
  pkgs,
  inputs,
  lib,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in {
  home.packages = with pkgs;
    [
      quickshell
    ]
    ++ [
      #inputs.mynixpkgs.packages.${pkgs.system}.dgop
      accountsservice
      brightnessctl
      cava
      cliphist
      ddcutil
      kdePackages.qt6ct
      khal
      material-symbols
      matugen
      swww
      wl-clipboard
      glib
    ];

  home.sessionVariables.QML2_IMPORT_PATH = lib.concatStringsSep ":" [
    "${quickshell}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"
    "${pkgs.kdePackages.kirigami.unwrapped}/lib/qt-6/qml"
  ];
}
