{ config, pkgs, ... }:

{
  imports = [
    ./latex.nix
    # ./nvim.nix
  ];

  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.enableNixpkgsReleaseCheck = false;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.bash = {
	  enable = true;
	  shellAliases = {
		r = "sudo nixos-rebuild switch";
		hr = "home-manager switch";
		hc = "cd ~/.config/home-manager && vim home.nix";
                cls = "clear";
                c = "cd /etc/nixos && sudo vim /etc/nixos/configuration.nix";
                vc = "cd ~/.config/home-manager/vim && vim .";
                lg = "lazygit";
                ff = "fastfetch";
	  };
          bashrcExtra = ''
            set -o noclobber

            GREEN="\[$(tput setaf 2)\]"
            RESET="\[$(tput sgr0)\]"
            PS1="$GREEN[\W]$RESET "

            shopt -s autocd
            eval "$(fzf --bash)"

            set -o vi
          '';
  };

  programs.zathura.enable = true;
  programs.zathura.extraConfig = ''
    set selection-clipboard clipboard

    map K zoom in
    map J zoom out

    map u scroll half-up
    map d scroll half-down

    set default-bg                  "#040D12"
    set recolor-lightcolor          "#040D12"
  '';

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      pkgs.vimPlugins.lazy-nvim
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
    ];
  };

  programs.vim = {
	  enable = true;
	  plugins = with pkgs.vimPlugins; [ jellybeans-vim  vimtex vim-snippets fzfWrapper ultisnips nerdcommenter vim-clang-format ];
	  settings = { ignorecase = true; };
          extraConfig = builtins.readFile ~/.config/home-manager/vim/vimrc;
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "neovim.desktop";
    "application/pdf" = "zathura.desktop";
    "image/*" = "nsxiv.desktop";
    "video/*" = "mpv.desktop";
  };

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.download = "$HOME/dws";
  xdg.userDirs.desktop = "$HOME/dsk";
  xdg.userDirs.documents = "$HOME/dox";
  xdg.userDirs.extraConfig = {
          XDG_TEMPLATES_DIR ="$HOME/tpl/";
          XDG_PUBLICSHARE_DIR = "$HOME/cmn/";
          XDG_MUSIC_DIR = "$HOME/sng/";
          XDG_PICTURES_DIR = "$HOME/ims/";
          XDG_VIDEOS_DIR = "$HOME/vds/";
          XDG_BIN_HOME = "$HOME/.local/bin";
        };

  programs.lf = {
    enable = true;
    extraConfig = ''
      map x delete

      set hidden true
    '';
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"

      set -s default-terminal 'tmux-256color'

      set -g prefix C-a
      set-option -g mouse on

      # Clipboard
      if-shell "uname | grep -q Darwin" {
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'reattach-to-user-namespace pbcopy'
      bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'reattach-to-user-namespace pbcopy'
      } {
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      bind-key -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      }

      # Pane navigation
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2
      bind -r - split-window -v
      bind -r + split-window -h
      bind q killp

      # Status bar
      set -g status-position bottom
      set-option -g automatic-rename on
      set-option -g status-interval 1
      set -g status-bg black
      set -g status-fg white
      set -g window-status-current-style 'fg=black,bg=green'

      # Vim moves
      setw -g mode-keys vi

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind -n C-h previous-window
      bind -n C-l next-window
    '';
  };

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 3;
    activeOpacity = 0.96;
    shadowOpacity = 0.8;
    # settings = {
    #   blur =
    #     { method = "gaussian";
    #     size = 10;
    #     deviation = 5.0;
    #     };
    #
    # };
  };

  programs.firefox = {
    enable = true;
    profiles.ilya = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        vimium
        youtube-shorts-block
      ];
      search.default = "DuckDuckGo";
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
      };
      modules = [
        "os"
        "wm"
        "terminal"
        "disk"
        "cpuusage"
        "colors"
        ];
      };
  };
}
