{ pkgs, ... }:

{
  users.users.ilya = {
    packages = with pkgs; [
      newsboat
      armcord
    ];
  };

  environment.systemPackages = with pkgs; [
    lazygit
    cmus
    htop
    pulsemixer
    sc-im
    tomato-c
    peaclock
  ];
}

