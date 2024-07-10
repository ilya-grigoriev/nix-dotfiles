with import <nixpkgs> {};

stdenv.mkDerivation rec {
    name = "surf";
    src = ./surf;

    nativeBuildInputs = [ pkg-config wrapGAppsHook3 ];
    buildInputs = [
      glib gcr glib-networking gsettings-desktop-schemas gtk3 libsoup webkitgtk
    ] ++ (with gst_all_1; 
    [
      gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad 
    ]);

    makeFlags = [ "PREFIX=$(out)" ];
    preFixup = let
      depsPath = lib.makeBinPath [ xorg.xprop dmenu findutils gnused coreutils ];
    in ''
      gappsWrapperArgs+=(
      --suffix PATH : ${depsPath}
      )
    '';
    # shellHook = ''
    #   export GIO_MODULE_DIR=${glib-networking}/lib/gio/modules/
    # '';
    # installPhase = ''
    #   mkdir -p $out/bin
    #   cp surf $out/bin
    # '';
  }
