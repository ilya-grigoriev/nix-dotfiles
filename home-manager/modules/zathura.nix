{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set selection-clipboard clipboard

      map K zoom in
      map J zoom out

      map u scroll half-up
      map d scroll half-down

    # set default-bg                  "#040D12"
    # set recolor-lightcolor          "#040D12"
      set default-bg rgba(0,0,0,0.7)
      set recolor-lightcolor rgba(0,0,0,0)
    '';
  };
}
