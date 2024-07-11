{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xorg.xinit
    dunst

    glib
    glib-networking

    xsel
    xclip
  ];
}
