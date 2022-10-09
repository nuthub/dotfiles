# -*- mode: nix -*-

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  imports =
    [ # Include the results of the hardware scan.
	    ./hardware-configuration.nix
    ];

  ## Boot loader
  boot.loader.efi.canTouchEfiVariables = true;
  # Use the grub boot loader in efi mode
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; # "nodev" for EFI mode, "/dev/XYZ" for MBR mode
  boot.loader.grub.theme = pkgs.nixos-grub2-theme;
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.loader.grub.gfxpayloadEfi = "1024x768";

  
  networking.hostName = "nutbook"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
	  font = "Lat2-Terminus16";
#	  keyMap = "de-latin1";
	  useXkbConfig = true; # use xkbOptions in tty.
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flake = {
	  initialPassword = "flake";
    uid = 1000; # currently 1001 sadly
	  isNormalUser = true;
	  shell = pkgs.zsh;
	  extraGroups = [ "wheel" # Enable ‘sudo’ for the user.
                    "networkmanager"
                    "vboxusers"
                    "disk" # to allow mounting/unmounting
                    "wireshark"
                    "video" # to allow to use xbacklight
                  ]; 
  };

  # Enable the X11 windowing system.
  services.xserver = {
	  enable = true;

	  desktopManager = {
	    xterm.enable = false;
	  };
	  displayManager = {
	    defaultSession = "none+i3";
	  };
	  windowManager.i3 = {
	    enable = true;
	    extraPackages = with pkgs; [
		    i3status
		    i3blocks
		    i3lock
        xss-lock
		    lxappearance # gui to configure gtk appearance
	    ];
	  };
	  
	  # Configure keymap in X11
	  layout = "de";
	  # xkbOptions = {
	  #   "eurosign:e";
	  #   "caps:escape" # map caps to escape.
	  # };
  };

  # go to sleep when lid is closed, even in docking station
  services.logind.lidSwitchDocked = "suspend";  

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.cups-toshiba-estudio
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Logitech: solaar, ltunify, udev-rules
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true; # for solaar to be included

  # backlight control
  hardware.acpilight.enable = true;
  programs.light.enable = true; # alternative to xbacklight
  
  # bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
	  enable = true;
	  permitRootLogin = "yes";
  };

  services.emacs.enable = true;

  # links /libexec from derivations to /run/current-system/sw
  environment.pathsToLink = [ "/libexec" ];

  environment.localBinInPath = true;


  nix = {
    package = pkgs.nixFlakes;
	  extraOptions = ''
                    experimental-features = nix-command flakes
  	'';
  };

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
	  alacritty # a terminal emulator
	  aqbanking
    arandr
	  AusweisApp2
    autorandr
	  baobab # graphical du
	  bash
    bat
	  bc
	  birdtray
	  bitwarden
    borgbackup
    brightnessctl
    chromium
	  curl
	  dia
	  discord
	  dmenu
	  docker
	  docker-compose
	  drawio
    dunst
    eclipses.eclipse-java
	  emacs
    feh
	  ffmpeg
	  firefox
	  gimp
	  gitFull
	  gnome.cheese
	  gnucash
	  google-chrome
	  gradle
	  imagemagick
	  inkscape
	  isync # needed by mu4e / contains mbsync
    jabref
    jetbrains.idea-ultimate
	  libreoffice
	  killall
	  mattermost-desktop
	  maven
	  mosquitto
	  mpv
	  mu # needed by (contains) mu4e
	  nextcloud-client
    neofetch # basic system information
    nixos-option
	  nmap
	  ntp
	  obs-studio
	  octave
	  optipng
	  pa_applet
	  pandoc
    pass
	  pasystray
	  pavucontrol
	  pdftk
	  pdfpc
    pinentry-qt
	  platformio
	  powertop
	  ripgrep
	  rocketchat-desktop
	  rofi
	  rsync
	  rxvt-unicode
	  shutter
	  simple-scan
	  samba
	  scenebuilder
	  skypeforlinux
	  spotify
    sqlite # org-roam needs it
	  stow # for my dotfiles
	  subversion
	  sweethome3d.application
	  sxiv
	  sysstat # for i3blocks
	  tdesktop # Telegram
	  teams
	  transmission # bittorrent client
	  trash-cli
	  tree
	  unp
	  unzip
	  usbutils # contains lsusb
	  vnstat # traffic statistics service
	  wireguard-tools
	  xfce.thunar
	  xfce.thunar-volman
	  xfce.thunar-archive-plugin
	  xournalpp
	  xsane
	  youtube-dl
	  yt-dlp
	  texlive.combined.scheme-full
	  thunderbird
	  udiskie
	  udisks2
	  vim
	  wget
	  zathura
	  zoom-us
  ];


  # fonts
  fonts.fonts = with pkgs; [
	  hack-font
	  font-awesome
	  #	nerdfonts # very large
	  noto-fonts
	  noto-fonts-cjk
	  noto-fonts-emoji
	  liberation_ttf
  ];


  programs.chromium.enable = true;
  programs.dconf.enable = true; # mindestens gnucash benötigt das
  programs.java.enable = true;
  programs.file-roller.enable = true;
  #    programs.git.enable = true;
  programs.htop.enable = true;
  programs.iftop.enable = true;
  programs.mtr.enable = true;
  programs.nm-applet.enable = true;
  programs.traceroute.enable = true;
  programs.wireshark.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    setOptions = [ "EMACS" ];
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      #      theme = "robbyrussell";
      theme = "frisk";
    };
  };

  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # make this machine a virtualbox host
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

}
