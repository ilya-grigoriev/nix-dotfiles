{
  home.packages = [ pkgs.tg ];  
  xdg.configFile."tg/conf.py".text = ''
    import os

    PHONE = ""
    DOWNLOAD_DIR = os.path.expanduser("~/dws/")

    COLOR = 40
    STEP = 10
    USERS_COLORS = tuple(range(COLOR, COLOR+STEP))

    CHAT_FLAGS = {
    "online": "●",
    "pinned": "P",
    "muted": "M",
    "unread": "U",
    "unseen": "✓",
    "secret": "🔒",
    "seen": "✓✓",
    }
    MSG_FLAGS = {
    "selected": "*",
    "forwarded": "F",
    "new": "N",
    "unseen": "U",
    "edited": "E",
    "pending": "...",
    "failed": "💩",
    "seen": "✓✓",
    }
  '';
}
