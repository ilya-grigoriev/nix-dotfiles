{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [ jellybeans-vim vimtex vim-snippets fzf-vim ultisnips nerdcommenter ale ];
    settings = { ignorecase = true; };
    extraConfig = builtins.readFile ~/.vim/vimrc;
  };
}
