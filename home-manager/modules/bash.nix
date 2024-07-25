{
  programs.bash = {
    enable = true;
    shellAliases = {
      r = "sudo nixos-rebuild switch";
      hr = "home-manager switch";
      hc = "cd ~/.config/home-manager && vim .";
      cls = "clear";
      c = "cd /etc/nixos && sudo vim .";
      vc = "cd ~/.config/home-manager/modules/vim/ && vim .";
      lg = "lazygit";
      ff = "fastfetch";
      sc = "sc-im";
      pir = "systemctl --user restart picom.service";
      nb = "newsboat";
      v = "vim";
      nv = "nvim";
      s = "nix-shell -p";
      b = "bluetuith";
      autoh = "echo ~/.config/home-manager/home.nix | entr sh -c 'home-manager switch'";
      auto = "echo /etc/nixos/configuration.nix | entr sh -c 'sudot nixos-rebuild switch'";
      rd = "tuir";
      br = "xrandr --output eDP-1 --brightness";
    };
    bashrcExtra = ''
      set -o noclobber

      GREEN="\[$(tput setaf 2)\]"
      RESET="\[$(tput sgr0)\]"
      PS1="$GREEN[\W]$RESET "

      shopt -s autocd
      eval "$(fzf --bash)"

      set -o vi

            # (cat ~/.cache/wal/sequences)
            # source ~/.cache/wal/colors-tty.sh
    '';
  };
}
