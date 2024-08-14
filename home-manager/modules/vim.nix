{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [ jellybeans-vim vimtex vim-snippets fzf-vim ultisnips ale vim-surround];
    settings = { ignorecase = true; };
    extraConfig = builtins.readFile ~/.vim/vimrc;
  };
}
