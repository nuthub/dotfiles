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
  networking.wireless.enable = false;
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ ];
  #networking.firewall.allowedUDPPorts = [ 51820 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

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
	  extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "vboxusers"
      "docker"
      "disk" # to allow mounting/unmounting
      "wireshark"
      "video" # to allow to use xbacklight
    ]; 
  };

  # Enable the X11 windowing system.
  services.xserver = {
	  enable = true;
    resolutions = [{
      x = 1920;
      y = 1080;
    }];

	  desktopManager = {
	    xterm.enable = false;
	  };
    
    displayManager = {
      defaultSession = "none+i3";
      session = [ {
        manage = "window";
        name = "emacs";
        start = ''
          dbus-launch --exit-with-session emacs -mm --debug-init --eval '(org-babel-load-file (expand-file-name "desktop.org" user-emacs-directory))'
          waitPID=$!
        '';
      } ];
    };
    
	  windowManager = {
      i3 = {
	      enable = true;
	      extraPackages = with pkgs;
          let
            polybar = pkgs.polybar.override {
              i3Support = true;
            };
          in
            [
	            acpi # for i3blocks
		          i3status
		          i3blocks
		          i3lock
              xss-lock
		          lxappearance # gui to configure gtk appearance
	            rofi
	            sysstat # for i3blocks
	          ];
      };
	  };
    
	  
	  # Configure keymap in X11
	  layout = "de";
	  xkbOptions = "caps:swapcaps"; # map caps to escape.
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

  # WWan support
  hardware.usbWwan.enable = true;

  # bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # List services that you want to enable:
  services.samba.package = pkgs.sambaFull;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Compositor
  services.picom.enable = true;

  # flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true; # flatpak needs this
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable the OpenSSH daemon.
  services.openssh = {
	  enable = true;
	  permitRootLogin = "yes";
  };

  #   services.emacs.enable = true;

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
    aspell
    aspellDicts.de
    aspellDicts.en
	  AusweisApp2
    autorandr
	  baobab # graphical du
	  bash
    bat
	  bc
    bind # dig and other tools
	  birdtray
	  bitwarden
    borgbackup
    brightnessctl
    chromium
	  curl
	  dia
	  discord
	  dmenu
    #	  docker
	  docker-compose
	  drawio
    dunst
    eclipses.eclipse-java
    eclipses.eclipse-modeling
    ((emacsPackagesFor emacsNativeComp).emacsWithPackages (
      epkgs: [
        epkgs.exwm
        epkgs.emacsql
        epkgs.emacsql-sqlite
        epkgs.vterm
        epkgs.pdf-tools
      ]))
    feh
	  ffmpeg
    file
	  firefox
    gcc # needed by emacs to compile emacssql
	  gimp
	  gitFull
	  gnome.cheese
    gnome.gnome-keyring
    gnome.seahorse
	  gnucash
	  google-chrome
	  gradle
    grub
    gtklp # lp interface
	  imagemagick
	  inkscape
    inetutils # telnet, traceroute, ping6 and more
	  isync # needed by mu4e / contains mbsync
    jabref 
    jetbrains.idea-ultimate # via flatpak
    libnotify # to send desktop notifications
	  libreoffice
	  killall
	  mattermost-desktop
	  maven
    modemmanager
    modem-manager-gui
	  mosquitto
	  mpv
	  mu # needed by (contains) mu4e
	  nextcloud-client
    neofetch # basic system information
    nixos-option
	  nmap
    nodejs
	  ntp
	  obs-studio
	  octave
	  optipng
	  pa_applet
	  pandoc
    pass
	  pasystray
	  pavucontrol
    pcmanfm
	  pdftk
	  pdfpc
    pinentry-qt
	  platformio
    polybarFull
	  powertop
    python3 # treemacs-git wants this
    qutebrowser
	  ripgrep
	  rocketchat-desktop
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
	  tdesktop # Telegram
	  teams
	  trash-cli
	  tree
	  unp
	  unzip
	  usbutils # contains lsusb
	  vnstat # traffic statistics service
	  wireguard-tools
    xfce.ristretto
	  xfce.thunar
	  xfce.thunar-volman
	  xfce.thunar-archive-plugin
    xfce.tumbler
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
    xorg.xev
    xorg.xinit
    xorg.xkill
    xorg.xmessage
	  zathura
	  zoom-us
  ];


  # fonts
  fonts.fonts = with pkgs; [
    cantarell-fonts
	  hack-font
	  font-awesome
    fira-code
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

  virtualisation.docker.enable = true;

}
