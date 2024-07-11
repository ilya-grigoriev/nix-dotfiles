{
  services.dwm-status.enable = true;
  services.dwm-status.extraConfig = ''
    separator = " | "

    [time]
    format = "%d.%m.%y %H:%M"

    [audio]
    template = "V: {VOL}%"
  '';
  services.dwm-status.order = ["audio" "battery" "time"];
}
