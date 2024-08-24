{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lorri
    direnv
    nurl
    nix-ld
    home-manager
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib

    xorg.libXcomposite
    xorg.libXtst
    xorg.libXrandr
    xorg.libXext
    xorg.libX11
    xorg.libXfixes
    libGL
    libva
  ];
}
