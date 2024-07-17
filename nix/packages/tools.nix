{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    poppler_utils
    ctags
    wget
    zip
    tmux
    git
    less
    pkg-config
    fzf
    fd
    ripgrep
    man
    usbutils
    entr
    unzip
    tldr
    bash-completion
    killall
    gnugrep
    bc
    perl538Packages.FileMimeInfo
    gh
    tree
    apg

    groff
    pandoc

    nnn
    lf

    vim
    neovim
  ];
}
