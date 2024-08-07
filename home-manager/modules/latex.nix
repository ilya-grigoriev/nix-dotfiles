{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
    scheme-medium
    dvisvgm dvipng
    lastpage enumitem
    lh cmap cyrillic cmcyr babel-russian hyphen-russian # For cyrillic
    anyfontsize multirow pdflscape titlesec pst-vectorian fncychap minted
    wrapfig amsmath ulem hyperref capt-of blindtext vmargin upquote listingsutf8 fancybox 
    tcolorbox environ pdfcol
    libertinus libertinus-type1 libertinus-otf droid
    ;
  });
in
{
  home.packages = with pkgs; [
    tex
  ];
}
