{ pkgs, ... }:

{
  programs.lf = {
    enable = true;
    extraConfig = ''
      map x delete
      map ,
      map ,w $wal -i "$f"
      map ,f $feh --bg-fill "$f"
    '';
    settings = {
      preview = true;
      hidden = true;
      ignorecase = true;
      drawbox = true;
    };
    previewer = {
      keybinding = "i";
      source = pkgs.writeShellScript "pv.sh" ''
                 #!/bin/sh

                 case "$1" in
                     *.tar*) tar tf "$1";;
                     *.zip) unzip -l "$1";;
                     *.rar) unrar l "$1";;
                     *.7z) 7z l "$1";;
                     *.pdf) pdftotext "$1" -;;
                     *) highlight -O ansi "$1" || cat "$1";;
                 esac
      '';
    };
  };
}
