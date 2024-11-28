;; This is my operating system configuration
(use-modules (gnu)
	     (gnu system locale)
	     (nongnu packages fonts)
	     (nongnu packages linux)
	     (nongnu packages mozilla)
	     (nongnu system linux-initrd))

(use-system-modules setuid)
(use-package-modules admin firmware gnome freedesktop linux networking package-management shells wm fonts)
(use-service-modules authentication cups dbus desktop docker linux networking pm samba ssh mcron virtualization xorg)

(define base-system
  (operating-system
   (host-name #f)
   (file-systems #f)
   (kernel linux)
   (kernel-loadable-modules (list v4l2loopback-linux-module)) 
   (initrd microcode-initrd)
   (locale "en_US.utf8")
   (locale-definitions (cons (locale-definition
			      (name "de_DE.utf8") (source "de_DE"))
			     %default-locale-definitions))
   (timezone "Europe/Berlin")
   (keyboard-layout (keyboard-layout "de" #:options '("ctrl:nocaps")))
   (name-service-switch %mdns-host-lookup-nss)
   (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(targets (list "/boot/efi"))
		(keyboard-layout keyboard-layout)))
   ;; The list of user accounts ('root' is implicit).
   (users (cons* (user-account
		  (name "flake")
		  (comment "Julian Flake")
		  (group "users")
		  (home-directory "/home/flake")
		  (shell (file-append zsh "/bin/zsh"))
		  (supplementary-groups '("users" "wheel" "netdev" "audio" "video" "tty"
					  "input" "disk" "kvm" "docker" "lp" "lpadmin"
					  "dialout" "libvirt"))) ;; lp is needed for bluetooth
		 %base-user-accounts))
   (setuid-programs
    (append (list (setuid-program
		   (program (file-append opendoas "/bin/doas")))
		  (setuid-program
		   (program (file-append libmbim "/bin/mbimcli"))))
	    %setuid-programs))
   (packages (append
	      (map
	       (compose list specification->package+output)
	       '(
		 ;; hardware related
		 "intel-vaapi-driver" "intel-media-driver-nonfree"
		 "libva-utils" "mesa"
		 ;; basics
		 "git" "git:send-email" "git:gui" "mumi"
		 "bash"
		 "gnupg"
		 "opendoas" ; install it additionally to make man pages available
		 "mailutils" ; rottlog seems to need this
		 ;; TLS root certificates
		 ;;"nss-certs" ; is part of %base-packages now (2024-04-21)
		 ;; emacs & related
		 "emacs-pgtk-xwidgets" "emacs-pdf-tools" "emacs-vterm"
		 "make" "perl" "texinfo" ; building auctex for elpaca needs these
		 "isync" "mu"
		 "vdirsyncer" "khal" "khard"
		 ;; Programming languages
		 "openjdk@21:jdk" ; java-lsp wants this, otherwise I'd just use it in guix shells only
		 "python" ; treemacs wants python3
		 ;; my shell and shell tools
		 "zsh" "zsh-autosuggestions" "zsh-syntax-highlighting"
		 "efibootmgr"
		 "bind:utils" ; for dig
		 "cups" ; for lpq
		 "file"
		 "fzf"
		 "htop"
		 "jq" ; needed by sway / zoom
		 "just"
		 "modem-manager" "libmbim" "modem-manager-fcc-auto-unlock" ; package auto-unlock has no effect
		 "neofetch"
		 "net-tools" ; for ifconfig  netstat  route
		 "nmap"
		 "bc" "octave"
		 "power-profiles-daemon" "powertop"
		 "ripgrep"
		 "stow"
		 "trash-cli"
		 "tree"
		 "unzip"
		 "usbutils"
		 "acpi"
		 "brightnessctl"
		 ;; syncing and versioning
		 "binutils" ;; for ar command
		 "borg"
		 "curl"
		 "glib:bin" ; has gio which allows to mount davfs as user
		 "rsync"
		 "subversion"
		 "nextcloud-client"
		 "yt-dlp"
		 "zip"
		 ;; Desktop start
		 ;; XDG
		 "xdg-utils" "xdg-user-dirs"
		 ;; I need all of these portals?
		 "xdg-desktop-portal-gtk" "xdg-desktop-portal-wlr" ; "xdg-desktop-portal" is propagated by xdg-desktop-portal-gtk
		 ;; wayland, not sure what I really need
		 "wlr-randr" "wdisplays" "slurp"
		 "grim" "swappy"
		 ;;"grimshot" "egl-wayland" "xorg-server-xwayland" 
		 ;; sway
		 "sway" "waybar" "wofi" "swaylock" "swayidle" "swaynotificationcenter" "libnotify"
		 "wl-mirror"
		 "wl-clipboard" "clipman" "wtype" ; wofi-emoji needs wtype
		 "wob" ; OSD overlay
		 "alacritty"
		 "kanshi" ; automatically switch displays
		 "gammastep" "geoclue" ; could use geoclue, if geoclue was running
		 ;; other desktop related
		 "tumbler" ; D-BUS thumbnail service
		 "gnome-keyring"
		 ;; connectivity / media
		 "pipewire" "pavucontrol" "wireplumber"
		 "bluez" "blueman"
		 "udiskie"
		 "solaar"
		 ;; Desktop end
		 "mosquitto" ;; for doorstatus in waybar
		 ;; other sources / hubs
		 ;; Flatpak in home profile
		 "flatpak" ; qtwebengine is required by Calibre flatpak to view ebooks (?)
		 "docker"
		 ;; security
		 "pinentry" "pinentry-tty" "pinentry-emacs" "gnupg" "openssh"
		 "wireguard-tools"
		 "lxqt-policykit"
		 "qt5ct"
		 ;; my desktop apps
		 "gvfs" "nemo" "file-roller" "baobab"
		 "librewolf" "ungoogled-chromium-wayland" "firefox" 
		 "icedove-wayland" ; thunderbird
		 ;; "aqbanking" "gnucash"
		 "libreoffice"
		 ;; Office, LaTeX, PDF & Co
		 "texlive" "texlive-biber" ;; JabRef is installed via flatpak
		 "enchant"
		 ;; "hunspell" "hunspell-dict-de" "hunspell-dict-en"
		 "aspell" "aspell-dict-de" "aspell-dict-en" ; aspell or hunspell? Good question
		 "pandoc"
		 "pdfpc"
		 "ghostscript" ;; for e.g. ps2pdf
		 "stapler"
		 ;; media
		 "inkscape" "graphviz"
		 "mpv" "imv"
		 "flameshot" "qtwayland@5.15.15" ; flameshot needs qtwayland@5
		 "gimp"
		 "imagemagick" "optipng"
		 "cheese" "obs" "handbrake" ; obs-wlrobs is not necessary, if pipewire is running
		 "simple-scan" "xsane"
		 ;; Virtualization
		 "qemu" "virt-manager" "ovmf-x86-64"
		 ;;
		 ;; Look & Feel
		 ;; fonts
		 "font-fira-code" ; "font-hack" is also nice, but doesn't support ligatures
		 "font-awesome6" ; some icons, unfortunately fontawesome is an outdated version: https://issues.guix.gnu.org/32916
		 ;; Nerd-Fonts are installed by M-x nerd-icons-install-fonts into .local/share/fonts
		 ;; all-the-icons are installed by M-x all-the-icons-install-fonts into .local/share/fonts
		 "font-google-noto" ; broad range of 
		 "font-google-noto-emoji" ; Emoji support
		 "font-google-noto-serif-cjk" "font-google-noto-sans-cjk" ; chinese fonts
		 "font-microsoft-arial" "font-microsoft-times-new-roman" "font-microsoft-courier-new" ; Microsoft fonts
		 ;; Theme
		 "materia-theme" "arc-theme" ; Arc theme is more actively maintained
		 ;; Icons:
		 ;; my primary icon theme is Papirus(-Dark)
		 ;; "papirus-icon-theme" ; disabled in system profile (see below)
		 ;; I manually installed papirus-icon-theme in my $HOME/.icons directory for two reasons:
		 ;;   1. flatpak apps take ages to start with Papirus-Icon-Theme in system's prof
		 ;;   2. it uses a lot of inodes: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/issues/3563 and https://issues.guix.gnu.org/68561 This becomes an issue with frequently reconfigured profiles
		 "hicolor-icon-theme" ; waybar/privacy uses icons from here
		 ;; Cursors
		 "xcursor-themes" "bibata-cursor-theme"
		 ;; from nutguix
		 "gtklp" ;"astah-professional"
		 ))
	      %base-packages))
   (services (append (list
		      (service openssh-service-type)
		      (service fprintd-service-type)
		      (service samba-service-type (samba-configuration
						   (enable-smbd? #t)
						   (config-file (plain-file "smb.conf" "\
[global]
map to guest = Bad User
logging = syslog@1

[public]
browsable = yes
path = /home/flake/Public
read only = yes
guest ok = yes
guest only = yes\n"))))
		      (simple-service 'doas-config-file etc-service-type
				      (list `("doas.conf"
					      ,(plain-file
						"doas.conf" "permit persist :wheel\n"))))
		      (simple-service 'fcc-unlock-link etc-service-type  ; has no effect
				      `(("ModemManager/fcc-unlock.d/1eac"
					 ,(file-append modem-manager "/share/ModemManager/fcc-unlock.available.d/1eac"))
					("ModemManager/fcc-unlock.d/1eac:1001"
					 ,(file-append modem-manager "/share/ModemManager/fcc-unlock.available.d/1eac:1001"))))
		      (simple-service 'v4l2loopback-options-file etc-service-type
				      (list `("modprobe.d/v4l2loopback.conf"
					      ,(plain-file
						"v4l2loopback.conf"
						"options v4l2loopback devices=1 exclusive_caps=1 card_label=\"v4l2loopback\""))))
		      (service kernel-module-loader-service-type '("v4l2loopback"))
		      ;; (service mcron-service-type
		      ;; 	       (mcron-configuration
		      ;; 		(jobs (list
		      ;; 		       #~(job "0 * * * *"
		      ;; 			      "/home/flake/.local/bin/sync-calendars.sh"
		      ;; 			      #:user "flake")
		      ;; 		       #~(job "30 * * * *"
		      ;; 			      "/home/flake/.local/bin/mbsync-all.sh"
		      ;; 			      #:user "flake")))))
		      (service bluetooth-service-type)
		      (service cups-service-type
			       (cups-configuration
				(web-interface? #t)
				(default-shared? #f)
				(default-paper-size "A4")))
		      (service power-profiles-daemon-service-type)
		      (service containerd-service-type)
		      (service docker-service-type)
		      (service gnome-keyring-service-type)
		      (service screen-locker-service-type
			       (screen-locker-configuration
				(name "swaylock")
				(program (file-append swaylock "/bin/swaylock"))
				(allow-empty-password? #f)
				(using-pam? #t)
				(using-setuid? #f)))
		      (service libvirt-service-type
			       (libvirt-configuration
				(unix-sock-group  "libvirt")))
		      (udev-rules-service 'solaar-udev-rules solaar)
		      ;; (udev-rules-service 'logitech-unify
		      ;; 		       (file->udev-rule
		      ;; 			"42-logitech-unify-permissions.rules"
		      ;; 			(file-append solaar "/share/solaar/udev-rules.d/42-logitech-unify-permissions.rules")))

		      ;;(service geoclue-service-type) 
		      ;; (simple-service 'geoclue-polkit-rule polkit-service-type 
		      ;; 		    (list (file-union
		      ;; 			   "polkit-geoclue"
		      ;; 			   `(("share/polkit-1/rules.d/geoclue.rules"
		      ;; 			      ,(file-append geoclue "/share/polkit-1/rules.d/org.freedesktop.GeoClue2.rules"))))))
		      (simple-service 'dbus-extras
				      dbus-root-service-type (list blueman)))
		     ;; This is the (modified) default list of services we are appending to.
		     (modify-services %desktop-services
				      (delete gdm-service-type)
				      (elogind-service-type
				       config => (elogind-configuration
						  (inherit config)
						  (handle-power-key 'suspend)
						  (handle-lid-switch-docked 'ignore)))
				      (guix-service-type
				       config => (guix-configuration
						  (inherit config)
						  (substitute-urls (append
								    (list "https://substitutes.nonguix.org")
								    %default-substitute-urls))
						  (authorized-keys (append
								    (list (local-file "./nonguix-signing-key.pub"))
								    %default-authorized-guix-keys)))))))))
