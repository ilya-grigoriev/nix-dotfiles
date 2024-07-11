{ config, pkgs, ... }:

{
  imports = [
    ./read_modules.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
}
