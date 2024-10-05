;; This is my operating system configuration

(use-modules (gnu)
	     (gnu system locale)
	     (guix channels)
	     (nongnu packages fonts)
	     (nongnu packages linux)
	     (nongnu packages mozilla)
	     (nongnu packages chromium)
	     (nongnu system linux-initrd))

(use-system-modules setuid)
(use-package-modules admin firmware gnome linux networking package-management shells wm)
(use-service-modules cups dbus desktop docker linux networking pm samba ssh syncthing mcron virtualization xorg)

;;;
;;; My OS
;;;
(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (kernel-loadable-modules (list v4l2loopback-linux-module)) 
 (locale "en_US.utf8")
 (locale-definitions (cons (locale-definition
			    (name "de_DE.utf8") (source "de_DE"))
			   %default-locale-definitions))
 (timezone "Europe/Berlin")
 (keyboard-layout (keyboard-layout "de" #:options '("ctrl:nocaps")))
 (host-name "nutbook")

 ;; The list of file systems that get "mounted".  The unique
 ;; file system identifiers there ("UUIDs") can be obtained
 ;; by running 'blkid' in a terminal.
 (file-systems (cons* (file-system (mount-point "/boot/efi")
				   (device (uuid "FCE6-96C0"
						 'fat32))
				   (type "vfat"))
		      (file-system (mount-point "/")
				   (device (uuid
					    "5c890181-055c-4db3-9a47-2e3769ec24ea"
					    'ext4))
				   (type "ext4"))
		      %base-file-systems))

 (swap-devices (list (swap-space
		      (target (uuid
			       "5abe7967-fcb6-4888-8b05-a6413944c60b")))))

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
		 (program (file-append opendoas "/bin/doas"))))
	  %setuid-programs))

 ;; Packages installed system-wide.
 (packages (append (map (compose list specification->package+output)
			'(
			  ;; hardware related
			  "i915-firmware"
			  "intel-vaapi-driver"
			  "intel-media-driver-nonfree" "libva-utils"
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
			  "neofetch"
			  "net-tools" ; for ifconfig  netstat  route
			  "nmap"
			  "bc" "octave"
			  "powertop"
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
			  "syncthing"
			  "nextcloud-client"
			  "yt-dlp"
			  "zip"
			  ;; Desktop start
			  ;; XDG
			  "xdg-utils" "xdg-user-dirs"
			  ;; I need all of these portals
			  "xdg-desktop-portal" "xdg-desktop-portal-gtk" "xdg-desktop-portal-wlr"
			  ;; wayland, not sure what I really need
			  "wlr-randr" "wdisplays" "slurp" ; "grim" "swappy" "grimshot" "egl-wayland" "xorg-server-xwayland" 
			  ;; sway
			  "sway" "waybar" "wofi" "swaylock" "swayidle" "swaynotificationcenter" "libnotify"
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
			  "mosquitto" ;; for doorstatus in polybar
			  ;; other sources / hubs
			  "flatpak"
			  "docker"
			  ;; security
			  "pinentry" "pinentry-tty" "gnupg" "openssh" "password-store"
			  "wireguard-tools" "openvpn" "network-manager-openvpn" "openfortivpn" "network-manager-fortisslvpn"
			  "lxqt-policykit"
			  "qt5ct"
			  ;; my desktop apps
			  "nemo" "file-roller" "baobab" "gvfs"
			  "ungoogled-chromium-wayland" "firefox-esr-wayland"
			  "icedove-wayland" ; thunderbird
			   ;;; "aqbanking" "gnucash"
			  "libreoffice"
			  ;; Office, LaTeX, PDF & Co
			  "texlive" "texlive-biber" ;; JabRef is installed via flatpak
			  "enchant"
			  "hunspell" "hunspell-dict-de" "hunspell-dict-en" ;; "aspell" "aspell-dict-de" "aspell-dict-en" ; aspell or hunspell? Good question
			  "pandoc"
			  "pdfpc"
			  "ghostscript" ;; for e.g. ps2pdf
			  "stapler"
			  ;; media
			  "inkscape" "graphviz"
			  "mpv" "imv"
			  "flameshot" "qtwayland@5.15.10" ; flameshot needs qtwayland@5
			  "ristretto" "gimp"
			  "imagemagick" "optipng"
			  "cheese" "ffmpeg" "obs" "handbrake" ; obs-wlrobs is not necessary, if pipewire is running
			  "simple-scan" "xsane"
			  ;; Virtualization
			  "qemu" "virt-manager" "ovmf-x86-64"
			  ;;
			  ;; Look & Feel
			  ;; fonts
			  "font-fira-code" ; "font-hack" is also nice, but doesn't support ligatures
			  "font-awesome" ; some icons
			  ;; Nerd-Fonts are installed by M-x nerd-icons-install-fonts
			  ;; all-the-icons are installed by M-x all-the-icons-install-fonts
			  "font-google-noto" ; broad range of 
			  "font-google-noto-emoji" ; Emoji support
			  "font-google-noto-serif-cjk" "font-google-noto-sans-cjk" ; chinese fonts
			  "font-microsoft-arial" "font-microsoft-times-new-roman" "font-microsoft-courier-new" ; Microsoft fonts
			  ;; themes
			  "gnome-themes-extra"
			  ;; icons
			  "adwaita-icon-theme"
			  "elementary-xfce-icon-theme" "hicolor-icon-theme" ; (gives nice icons in waybar also)
			  ;; from nutguix
			  "wl-mirror" "gtklp" "astah-professional"
			  ))
		   %base-packages))

 ;; Below is the list of system services.  To search for available
 ;; services, run 'guix system search KEYWORD' in a terminal.
 (services
  (append (list
	   (service openssh-service-type)
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
	   (simple-service 'v4l2loopback-options-file etc-service-type
			   (list `("modprobe.d/v4l2loopback.conf"
				   ,(plain-file
				     "v4l2loopback.conf"
				     "options v4l2loopback devices=1 exclusive_caps=1 card_label=\"v4l2loopback\""))))
	   (service syncthing-service-type
		    (syncthing-configuration
		     (user "flake")))
	   (service mcron-service-type
                    (mcron-configuration
                     (jobs (list
			    #~(job "0 * * * *"
				   "/home/flake/.local/bin/sync-calendars.sh"
				   #:user "flake")
			    #~(job "30 * * * *"
				   "/home/flake/.local/bin/mbsync-all.sh"
				   #:user "flake")))))
	   (service bluetooth-service-type)
	   (service cups-service-type
		    (cups-configuration
		     (web-interface? #t)
		     (default-paper-size "A4")))
	   (service tlp-service-type)
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
	   (service kernel-module-loader-service-type '("v4l2loopback"))
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
				       (handle-lid-switch-docked 'ignore)))
			   (guix-service-type
			    config => (guix-configuration
				       (inherit config)
				       (substitute-urls (append
							 (list "https://substitutes.nonguix.org")
							 %default-substitute-urls))
				       (authorized-keys (append
							 (list (local-file "./nonguix-signing-key.pub"))
							 %default-authorized-guix-keys)))))))

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))

