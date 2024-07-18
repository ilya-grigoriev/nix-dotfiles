{ pkgs, ... }:

{
  home.packages = [ pkgs.tuir ];
  xdg.configFile."tuir/tuir.cfg".text = ''
    [tuir]
    monochrome = False
    theme = default

    flash = False
    subreddit = front
    persistent = False
    autologin = False
    clear_auth = True
    history_size = 200
    enable_media = True
    max_comment_cols = 120
    hide_username = True
  '';
}
