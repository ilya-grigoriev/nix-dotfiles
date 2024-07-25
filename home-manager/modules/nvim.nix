{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      luasnip # for snippets

      kanagawa-nvim
      vim-be-good
      nvim-treesitter.withAllGrammars
      telescope-nvim
      nerdcommenter

      nvim-cmp
      nvim-lspconfig # for setup LSP
      mason-nvim # for installing linters and formatters
      cmp-nvim-lsp # without this dont work autocompletion
      null-ls-nvim # for setup linters and formatters
    ];
  };
}
