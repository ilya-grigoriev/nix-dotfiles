{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg
    yt-dlp
    mpd
    sof-firmware
  ];
}
