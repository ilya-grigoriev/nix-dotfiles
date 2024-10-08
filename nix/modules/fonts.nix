{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
    monocraft
    terminus_font
    iosevka
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}
