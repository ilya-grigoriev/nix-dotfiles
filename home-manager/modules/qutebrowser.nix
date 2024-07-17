{
  programs.qutebrowser = {
    enable = true;
    quickmarks = {
      s = "https://search.nixos.org/packages";
      w = "https://nixos.wiki/";
      y = "https://youtube.com/";
      mg = "https://github.com/ilya-grigoriev";
      t = "https://translate.yandex.com/";
      d = "https://detexify.kirelabs.org/classify.html";
      l = "https://ctan.org/";
    };
    keyBindings = {
      normal = {
        "t" = "open -t";
        "<Ctrl-h>" = "history";
        ",h" = "help";
      };
    };
    settings = {
      auto_save.session = true;
      content.webgl = false;

      colors.webpage.darkmode.enabled = true;
      colors.webpage.darkmode.policy.images = "never";
      colors.webpage.bg = "black";

      colors.tabs.bar.bg = "black";
      colors.tabs.odd.fg = "#CCCCCC"; # "#A9A9A9"
      colors.tabs.odd.bg = "black";
      colors.tabs.even.fg = "#CCCCCC"; # "#A9A9A9"
      colors.tabs.even.bg = "black";
      colors.tabs.selected.odd.fg = "#CCCCCC";
      colors.tabs.selected.odd.bg = "#3C3C3C";
      colors.tabs.selected.even.fg = "#CCCCCC";
      colors.tabs.selected.even.bg = "#3C3C3C";

      fonts.default_size = "13pt";
      fonts.default_family = "Monocraft Nerd Font";
      fonts.tabs.selected = "12pt Monocraft";
      fonts.tabs.unselected = "12pt Monocraft";

      statusbar.widgets = [ "url" ];
      tabs.max_width = 350;
      tabs.title.format = "{current_title}";

      zoom.default = "150%";

      url.default_page = "about:blank";
      url.start_pages = [ "about:blank" ];
      tabs.last_close = "default-page";

      downloads.remove_finished = 5000;
    };
  };
}
