{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.lazy-nvim
      pkgs.vimPlugins.luasnip
    ];
  };
}
