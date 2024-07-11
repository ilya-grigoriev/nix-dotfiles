{ pkgs, ... }:

{
	services.xserver.enable = true;
	services.xserver.autorun = true;

	services.xserver.displayManager.lightdm.enable = true;
	services.xserver.displayManager.lightdm.background = /etc/nixos/wallpaper.png;

	environment.variables = {
		GDK_SCALE = "1";
#	  GDK_DPI_SCALE = "0.5";
#	  _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
	};

	services.xserver.windowManager.dwm = {
		enable = true;
		package = pkgs.dwm.overrideAttrs { 
			src = /etc/nixos/modules/dwm; 
		};
	};

	services.xserver.xkb.layout = "us,ru";
	services.xserver.xkb.options = "grp:alt_shift_toggle,caps:ctrl_modifier";

}
