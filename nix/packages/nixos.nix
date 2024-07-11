{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lorri
    direnv
    nurl
    home-manager
  ];
}
