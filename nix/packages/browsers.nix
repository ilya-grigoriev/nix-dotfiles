{ pkgs, ... }:

{
  users.users.ilya = {
    packages = with pkgs; [
      librewolf
      chromium
      qutebrowser
      links2
    ];
  };

  environment.systemPackages = with pkgs; [
    w3m
    lynx
    (import /etc/nixos/modules/surf.nix)
  ];
}
