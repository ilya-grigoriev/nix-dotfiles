{
  programs.yt-dlp = {
    enable = true;
    extraConfig = ''
      --audio-format best
      --audio-format mp3
      -P "~/sng"
      -x
    '';
  };
}
