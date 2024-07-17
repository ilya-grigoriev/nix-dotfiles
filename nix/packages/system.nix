{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xorg.xinit
    dunst

    glib
    glib-networking
    sysstat

    xsel
    xclip

    android-tools
    android-file-transfer
  ];
}
