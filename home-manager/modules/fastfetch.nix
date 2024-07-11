{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
      };
      modules = [
        "os"
        "wm"
        "terminal"
        "disk"
        "cpuusage"
        "colors"
      ];
    };
  };
}
