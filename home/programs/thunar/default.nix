# Thunar is a file explorer
{
  pkgs,
  config,
  ...
}: let
  user = config.var.username;
in {
  # ctrl + m to toggle the menubar
  home.packages = with pkgs; [
    xfce.thunar
    xfce.xfconf
    xfce.tumbler
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin
    p7zip
    xarchiver
  ];

  gtk = {
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme.override {
        boldPanelIcons = true;
        alternativeIcons = true;
      };
    };
  };

  home.sessionVariables = {
    XDG_ICON_DIR = "${pkgs.whitesur-icon-theme}/share/icons/WhiteSur";
  };

  # bookmarks for the side pane
  gtk.gtk3.bookmarks = [
    "file:///home/${user}/Downloads Downloads"
    "file:///home/${user}/Pictures Pictures"
    "file:///home/${user}/nextcloud Nextcloud"
    "file:///home/${user}/.config/nixos NixOS"
    "file:///home/${user}/dev Development"
  ];

  /*
    home.file.".config/xarchiver/xarchiverrc".text = ''
    [xarchiver]
    preferred_format=0
    prefer_unzip=true
    confirm_deletion=true
    sort_filename_content=false
    advanced_isearch=true
    auto_expand=true
    store_output=false
    icon_size=2
    show_archive_comment=false
    show_sidebar=true
    show_location_bar=true
    show_toolbar=true
    preferred_custom_cmd=
    preferred_temp_dir=/tmp
    preferred_extract_dir=/home/${user}/Downloads
    allow_sub_dir=0
    ensure_directory=true
    overwrite=false
    full_path=2
    touch=false
    fresh=false
    update=false
    store_path=false
    updadd=true
    freshen=false
    recurse=true
    solid_archive=false
    remove_files=false
  '';
  */
}
