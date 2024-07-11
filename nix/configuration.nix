# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" ];

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
  # services.xserver.displayManager.sessionCommands = ''
  #   curl -sk https://raw.githubusercontent.com/ilya-grigoriev/dotfiles/main/ims/wallpapers/grey.jpg | feh --bg-fill -
  # '';

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.background = /etc/nixos/wallpaper.png;
  # services.xserver.displayManager.startx.enable = true;
  environment.variables = {
	  GDK_SCALE = "1";
#	  GDK_DPI_SCALE = "0.5";
#	  _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs { 
      src = ./dwm; 
    };
  };


  services.dwm-status.enable = true;
  services.dwm-status.extraConfig = ''
    separator = " | "

    [time]
    format = "%d.%m.%y %H:%M"

    [audio]
    template = "V: {VOL}%"
  '';
  services.dwm-status.order = ["audio" "battery" "time"];
  

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
     
     librewolf
     chromium
     qutebrowser

     tree
     dmenu
     (st.overrideAttrs (oldAttrs: rec {
			src = ./st;
			}))
     pkgs.xorg.libX11
     pkgs.xorg.libXinerama
     pkgs.xorg.libXft
     gcc
     gdb
     clang-tools
     flameshot
     picom
     spotify
     armcord

     R
     manim
     newsboat
     links2
   ];
 };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   	vim 
        poppler_utils
        imagemagick
        ctags
        ffmpeg
        sbcl
        sc-im
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
        glib
        glib-networking
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
        killall
	kolourpaint
	cmake
	mpv
	zathura
	gimp
        screenkey

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

        (pkgs.python3.withPackages (python-pkgs: [
          python-pkgs.requests
        ]))
        python313
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
        lorri
        direnv

        libreoffice-qt6-still
        (import ./surf.nix)

        perl538Packages.FileMimeInfo
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

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
	  [Settings]
	  gtk-application-prefer-dark-theme=1
		  '';

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

