{ pkgs, ... }:

{
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
}
