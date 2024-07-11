{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [ jellybeans-vim  vimtex vim-snippets fzfWrapper ultisnips nerdcommenter vim-clang-format ];
    settings = { ignorecase = true; };
    extraConfig = builtins.readFile ~/.config/home-manager/modules/vim/vimrc;
  };
}
