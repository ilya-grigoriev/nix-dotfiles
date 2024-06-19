# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = "nix-command";

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  environment.variables = {
	  GDK_SCALE = "1";
#	  GDK_DPI_SCALE = "0.5";
#	  _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services.xserver.windowManager.awesome.enable = true;

  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs { 
      src = ./dwm; 
    };
  };
  # nixpkgs.overlays = [
  #   (self: super: {
  #     dwm = super.dwm.overrideAttrs (oldAttrs: rec {
  #       configFile = super.writeText "config.h" (builtins.readFile ./dwm/config_dwm.h);
  #       postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${configFile} config.def.h";
  #     });
  #   })
  # ];
  #
  # services.xserver.windowManager.dwm.enable = true;

  # services.xserver.windowManager.dwm = {
  #   enable = true;
  #   package = pkgs.dwm.override {
  #     conf = builtins.readFile ./dwm/config.h;
  #   };
  # };
  # services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
  #   src = /home/ilya/.config/dwm;
  # };


  services.dwm-status.enable = true;
  services.dwm-status.order = ["battery" "time"];
  

  # Configure keymap in X11
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle,caps:ctrl_modifier";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ilya = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
     vim
     brave
     tree
     dmenu
     (st.overrideAttrs (oldAttrs: rec {
			configFile = writeText "config.def.h" (builtins.readFile /home/ilya/.config/st2/config.h);
			postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
			}))
     pkgs.xorg.libX11
     pkgs.xorg.libXinerama
     pkgs.xorg.libXft
     gcc
     flameshot
     picom
     spotify
     ];
   };

  environment.sessionVariables = rec {
	  XDG_CACHE_HOME  = "$HOME/.cache";
	  XDG_CONFIG_HOME = "$HOME/.config";
	  XDG_DATA_HOME   = "$HOME/.local/share";
	  XDG_STATE_HOME  = "$HOME/.local/state";
          XDG_DESKTOP_DIR = "$HOME/dsk/";
          XDG_DOWNLOAD_DIR = "$HOME/dws/";
          XDG_TEMPLATES_DIR ="$HOME/tpl/";
          XDG_PUBLICSHARE_DIR = "$HOME/cmn/";
          XDG_DOCUMENTS_DIR = "$HOME/dox/";
          XDG_MUSIC_DIR = "$HOME/sng/";
          XDG_PICTURES_DIR = "$HOME/ims/";
          XDG_VIDEOS_DIR = "$HOME/vds/";
	  XDG_BIN_HOME = "$HOME/.local/bin";
	  PATH = [ 
		  "${XDG_BIN_HOME}"
	  ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   	wget
	zip
   	tmux
	fastfetch
	tmux
	git
	less
	htop
	lynx
	w3m
	pkg-config
	gnumake
	lolcat
	fzf
	fd
	ripgrep
	lua
	man 
	usbutils
	entr
	pandoc 
	yt-dlp
	unzip 
	feh
	xsel
	xclip
	tldr
	bash-completion
	kolourpaint
	cmake
	mpv
	zathura
	gimp

	nnn
	lf

	cmus
	obs-studio
	gnugrep
	bc
	xorg.xinit
	dunst
	gh
	lazygit
	groff
	gummy

	bluetuith
	bluez
	bluez-tools

	pyenv
	pipx
	telegram-desktop
	home-manager
	mpd
	pkgs.xorg.libX11
	pkgs.xorg.libXinerama
	pkgs.xorg.libXft
	gcc
	nsxiv
	pkgs.neovim

	texlive.combined.scheme-medium
	texlivePackages.cyrillic
	texlivePackages.dvipdfmx

	pulsemixer
	nurl
        pkgs.lua54Packages.luarocks
        pkgs.nodejs_22
        pyenv
        pkgs.cargo

        pywal
	];

  fonts.packages = with pkgs; [
	  noto-fonts
	  noto-fonts-cjk
	  noto-fonts-emoji
	  liberation_ttf
	  fira-code
	  fira-code-symbols
	  mplus-outline-fonts.githubRelease
	  dina-font
	  proggyfonts
	  jetbrains-mono
	  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

