{ pkgs, ... }:

{
  home.packages = [ pkgs.discordo ];
  xdg.configFile."discordo/config.toml".text = ''
    timestamps = true
    timestamps_format = "2006-01-02 15:04:05"

    [keys]
    focus_guilds_tree = "Ctrl+N"
    focus_messages_text = "Ctrl+K"
    focus_message_input = "Ctrl+J"

    [keys.guilds_tree]
    select_current = "Rune[l]"

    [keys.messages_text]
    select_reply = "Rune[s]"
    reply = "Rune[r]"
    reply_mention = "Rune[R]"
    delete = "Rune[d]"
    yank = "Rune[y]"
    open = "Rune[o]"

    [theme.guilds_tree]
    auto_expand_folders = true
    graphics = true

    [theme.messages_text]
    author_color = "aqua"
    reply_indicator = "╭ "

    [theme]
    border = true
    border_color = "default"
    border_padding = [0, 0, 1, 1]
    title_color = "#FFB4C2"
    background_color = "default"
  '';
}
