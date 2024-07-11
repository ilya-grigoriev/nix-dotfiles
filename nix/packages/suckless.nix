{ pkgs, ... }:

{
  users.users.ilya = {
    packages = with pkgs; [
      dmenu
      (st.overrideAttrs (oldAttrs: rec {
        src = /etc/nixos/modules/st;
      }))
      pkgs.xorg.libX11
      pkgs.xorg.libXinerama
      pkgs.xorg.libXft
    ];
  };
}

