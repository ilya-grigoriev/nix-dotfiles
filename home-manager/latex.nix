{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
    scheme-medium
    dvisvgm dvipng
    lastpage enumitem
    lh cmap cyrillic cmcyr babel-russian # For cyrillic
    anyfontsize multirow pdflscape titlesec pst-vectorian fncychap
    wrapfig amsmath ulem hyperref capt-of
    ;
  });
in
{
  home.packages = with pkgs; [
    tex
  ];
}
