{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 3;
    activeOpacity = 0.96;
    shadowOpacity = 0.8;
    backend = "glx";
    settings = {
      blur = {
        method = "gaussian";
        size = 20;
        deviation = 6.0;
      };
      blur-background-exclude = [
        "window_type = 'menu'"
        "window_type = 'dropdown_menu'"
        "window_type = 'popup_menu'"
        "window_type = 'tooltip'"
        "class_g = 'chromium' && argb"
      ];
      unredir-if-possible = false;
    };
    opacityRules = [
      "100:class_g *= 'st' && !focused"
      "100:class_g *= 'st' && focused"
    ];
  };
}
