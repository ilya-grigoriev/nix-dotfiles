{ pkgs, ... }:

{
  users.users.ilya = {
    packages = with pkgs; [
      picom
    ];
  };

  environment.systemPackages = with pkgs; [
    pywal
    gummy
    screenkey
    feh
    imagemagick
    lolcat
    fastfetch
  ];
}
