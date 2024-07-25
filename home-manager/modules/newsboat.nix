{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    urls = [
      {
        tags = [ "arch" ];
        url = "https://archlinux.org/feeds/news/";
      }
      {
        tags = [ "blog" ];
        url = "https://lukesmith.xyz/index.xml";
      }
      {
        tags = [ "nix" ];
        url = "https://nixos.org/blog/announcements-rss.xml";
      }
      {
        tags = [ "arch" ];
        url = "https://archlinux.org/feeds/packages/";
      }
      {
        tags = [ "latex"];
        url = "https://tex.stackexchange.com/feeds";
      }
    ];
    extraConfig = ''
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit

      unbind-key Q
      unbind-key q
      bind-key q hard-quit

      browser surf

      macro v set browser "mpv --really-quiet --no-terminal" ; open-in-browser ; set browser chromium
    '';
  };
}
