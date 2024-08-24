{ pkgs, ... }:

{
  users.users.ilya = {
    packages = with pkgs; [
      gcc
      gdb
      clang-tools

      R
      go
    ];
  };

  environment.systemPackages = with pkgs; [
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.requests
    ]))
    python313
    pipx
    pyenv

    gcc
    pkgs.xorg.libX11
    pkgs.xorg.libXinerama
    pkgs.xorg.libXft
    cmake
    gnumake

    lua
    pkgs.lua54Packages.luarocks
    
    pkgs.nodejs_22
    pkgs.cargo
    sbcl
  ];
}
