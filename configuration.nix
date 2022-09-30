# -*- mode: nix -*-

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
	    ./hardware-configuration.nix
	    <home-manager/nixos>
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nutbook"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
	  font = "Lat2-Terminus16";
	  keyMap = "de-latin1";
	  #   useXkbConfig = true; # use xkbOptions in tty.
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
		    rofi
		    dmenu
		    arandr
		    xfce.thunar
		    xfce.thunar-volman
		    xfce.thunar-archive-plugin
		    lxappearance # gui to configure gtk appearance
		    rxvt-unicode
	    ];
	  };
	  
	  # Configure keymap in X11
	  layout = "de";
	  # xkbOptions = {
	  #   "eurosign:e";
	  #   "caps:escape" # map caps to escape.
	  # };
  };
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flake = {
	  initialPassword = "flake";
	  isNormalUser = true;
	  shell = pkgs.zsh;
	  extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
  users.extraGroups.vboxusers.members = [ "flake" ];

  # links /libexec from derivations to /run/current-system/sw
  # environment.pathsToLinks = [ "/libexec" ];




  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #    programs.mtr.enable = true;
  #    programs.gnupg.agent = {
  #	enable = true;
  #	enableSSHSupport = true;
  #    };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
	  enable = true;
	  permitRootLogin = "yes";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?


  nix = {
	  package = pkgs.nixFlakes;
	  extraOptions = ''
	experimental-features = nix-command flakes
	'';
  };

  # make this machine a virtualbox host
  nixpkgs.config.allowUnfree = true;
  #    virtualisation.virtualbox.host.enable = true;
  #    virtualisation.virtualbox.host.enableExtensionPack = true;

  environment.systemPackages = with pkgs; [
	  acpi # for i3blocks
	  acpilight # for i3blocks
	  alacritty # a terminal emulator
	  aqbanking
	  AusweisApp2
	  baobab # graphical du
	  bash
	  bc
	  biber # latex
	  birdtray
	  bitwarden
	  blueman
	  borgbackup
	  chromium
	  curl
	  dia
	  discord
	  docker
	  docker-compose
	  drawio
	  emacs
	  ffmpeg
	  firefox
	  gcc # needed by mu4e
	  gimp
	  gitFull
	  gnome.cheese
	  gnucash
	  gnupg
	  google-chrome
	  gradle
	  imagemagick
	  inkscape
	  isync # needed by mu4e
	  #	libreoffice
	  killall
	  llvm # needed to build mu4e
	  mattermost-desktop
	  maven
	  meson # needed by mu4e
	  mosquitto
	  mpv
	  mu # needed by (contains) mu4e
	  nextcloud-client
	  ninja # needed by mu4e
	  nmap
	  ntp
	  # large:	obs-studio
	  octave
	  optipng
	  pa_applet
	  pandoc
	  pasystray
	  pavucontrol
	  pdftk
	  pdfpc
	  platformio
	  powertop
	  ripgrep
	  rocketchat-desktop
	  rsync
	  shutter
	  simple-scan
	  samba
	  scenebuilder
	  skypeforlinux
	  solaar # logitech applet
	  spotify
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
	  usbutils
	  vnstat
	  wireguard-tools
	  xournalpp
	  xsane
	  youtube-dl
	  yt-dlp
	  # large:	texlive.combined.scheme-full
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
  programs.java.enable = true;
  programs.file-roller.enable = true;
  #    programs.git.enable = true;
  programs.htop.enable = true;
  programs.iftop.enable = true;
  programs.light.enable = true;
  programs.mtr.enable = true;
  programs.nm-applet.enable = true;
  programs.traceroute.enable = true;
  programs.wireshark.enable = true;

}

