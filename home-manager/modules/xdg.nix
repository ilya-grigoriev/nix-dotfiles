{ config, ... }:

{
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
  xdg.desktopEntries = {
    nsxiv = {
      name = "nsxiv";
      exec = "nsxiv -a %f";
    };
    chromium = {
      name = "chromium";
      exec = "chromium %u";
    };
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "chromium.desktop";
      "x-scheme-handler/https" = "chromium.desktop";
      "text/html" = "chromium.desktop";
      "x-scheme-handler/about" = "chromium.desktop";
      "x-scheme-handler/unknown" = "chromium.desktop";


      "text/plain" = "vim.desktop";
      "application/pdf" = "zathura.desktop";

      "image/jpeg" = "nsxiv.desktop";
      "image/png" = "nsxiv.desktop";
      "image/webp" = "nsxiv.desktop";
      "image/gif" = "nsxiv.desktop";

      "video/*" = "mpv.desktop";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    download = "$HOME/dws";
    desktop = "$HOME/dsk";
    documents = "$HOME/dox";
    extraConfig = {
      XDG_TEMPLATES_DIR ="$HOME/tpl/";
      XDG_PUBLICSHARE_DIR = "$HOME/cmn/";
      XDG_MUSIC_DIR = "$HOME/sng/";
      XDG_PICTURES_DIR = "$HOME/ims/";
      XDG_VIDEOS_DIR = "$HOME/vds/";
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
  };
}
