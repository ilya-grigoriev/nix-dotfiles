{ config, ... }:
let
  config_nvim = builtins.fetchGit {
    url = "https://github.com/ilya-grigoriev/nvim";
  };
in
  {
    home.file.".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "~/.config/home-manager/nvim_config";
    };
}
