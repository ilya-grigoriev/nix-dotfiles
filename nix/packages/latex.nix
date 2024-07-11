{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-medium
    texlivePackages.cyrillic
    texlivePackages.dvipdfmx
  ];
}
