#!/bin/sh

# Setup nixos
sudo cp -r nix/* /etc/nixos/

# Installing home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Setup home-manager
mkdir ~/.config/home-manager
sudo cp -r home-manager/* ~/.config/home-manager/
