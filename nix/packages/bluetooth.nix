{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bluetuith
    bluez
    bluez-tools
  ];
}
