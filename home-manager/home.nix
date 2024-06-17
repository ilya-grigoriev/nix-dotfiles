{ config, pkgs, ... }:

{
  imports = [
    ./latex.nix
    # ./nvim.nix
  ];

  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.enableNixpkgsReleaseCheck = false;

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.bash = {
	  enable = true;
	  shellAliases = {
		rebuild = "sudo nixos-rebuild switch";
		home-rebuild = "home-manager switch";
		home-config = "cd ~/.config/home-manager && vim home.nix";
                cls = "clear";
	  };
          bashrcExtra = ''
            set -o noclobber

            GREEN="\[$(tput setaf 2)\]"
            RESET="\[$(tput sgr0)\]"
            PS1="$GREEN[\W]$RESET "

            shopt -s autocd
          '';
  };

  programs.zathura.enable = true;
  programs.zathura.extraConfig = ''
    set selection-clipboard clipboard

    map K zoom in
    map J zoom out

  '';

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # plugins = [
    #   pkgs.vimPlugins.lazy-nvim
      # pkgs.vimPlugins.telescope-nvim
      # pkgs.vimPlugins.plenary-nvim
      # pkgs.vimPlugins.nvim-cmp
      # pkgs.vimPlugins.nvim-lspconfig
      # pkgs.vimPlugins.null-ls-nvim
      # pkgs.vimPlugins.cmp-nvim-lsp
      # pkgs.vimPlugins.mason-nvim
      # pkgs.vimPlugins.mason-lspconfig-nvim
      # pkgs.vimPlugins.neodev-nvim
      # pkgs.vimPlugins.lsp_signature-nvim
      # pkgs.vimPlugins.chadtree
      # pkgs.vimPlugins.kanagawa-nvim
      # pkgs.vimPlugins.comment-nvim
      # pkgs.vimPlugins.nvim-web-devicons
      # pkgs.vimPlugins.gitsigns-nvim
      # pkgs.vimPlugins.luasnip
      # pkgs.vimPlugins.friendly-snippets
      # pkgs.vimPlugins.cmp_luasnip
      # pkgs.vimPlugins.playground
      # pkgs.vimPlugins.fzfWrapper
      # pkgs.vimPlugins.nvim-jdtls
      # pkgs.vimPlugins.neogen
      # pkgs.vimPlugins.vimtex
      # pkgs.texlab
    # ];
  };

  programs.vim = {
	  enable = true;
	  plugins = with pkgs.vimPlugins; [ jellybeans-vim  vimtex vim-snippets fzfWrapper ultisnips YouCompleteMe nerdcommenter ];
	  settings = { ignorecase = true; };
          extraConfig = builtins.readFile ~/.config/home-manager/vim/vimrc;
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "neovim.desktop";
    "application/pdf" = "zathura.desktop";
    "image/*" = "nsxiv.desktop";
    "video/*" = "mpv.desktop";
  };
}
