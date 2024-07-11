{ pkgs, ... }:

{
  users.users.ilya = {
    packages = with pkgs; [
      spotify
      armcord
      flameshot
    ];
  };

  environment.systemPackages = with pkgs; [
    kolourpaint
    gimp
    zathura
    obs-studio
    telegram-desktop
    nsxiv
    libreoffice-qt6-still
    mpv
  ];
}

