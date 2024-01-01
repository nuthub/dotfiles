;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.

;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (gnu packages firmware)
	     (gnu packages linux)
	     (gnu packages networking)
	     (gnu packages shells)
	     (gnu packages wm)
	     (gnu packages gnome) ; for geoclue polkit service
	     (gnu packages admin)
	     (gnu services cups)
	     (gnu services dbus)
	     (gnu services desktop)
	     (gnu services docker)
	     (gnu services linux)
	     (gnu services networking)
	     (gnu services pm)
	     (gnu services ssh)
	     (gnu services syncthing)
	     (gnu services virtualization)
	     (gnu services xorg)
	     (nongnu packages fonts)
	     (nongnu packages linux)
	     (nongnu packages mozilla)
	     (nongnu packages chromium)
	     (nongnu system linux-initrd))

;;;
;;; My OS
;;;
(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (kernel-loadable-modules (list v4l2loopback-linux-module))
 (locale "en_US.utf8")
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

 ;; Packages installed system-wide.
 (packages (append (map (compose list specification->package+output)
			'(
			  ;; hardware related
			  "i915-firmware"
			  "intel-vaapi-driver"
			  ;; basics
			  "git" "git:send-email" "git:gui" 
			  "bash"
			  "gnupg"
			  ;; TLS root certificates
			  "nss-certs"
			  ;; emacs & related
			  "emacs-pgtk" "emacs-pdf-tools" "emacs-vterm"
			  "isync" "mu"
			  "openjdk@17.0.5:jdk" ; java-lsp wants this
			  "python" ; treemacs wants python3
			  ;; my shell and shell tools
			  "zsh" "zsh-autosuggestions" "zsh-syntax-highlighting"
			  "bind:utils"
			  "cups" ;; to have commands like lpq etc
			  "file"
			  "efibootmgr"
			  "htop"
			  "neofetch"
			  "just"
			  "net-tools"
			  "nmap"
			  "octave"
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
			  "davfs2"
			  "rsync"
			  "samba"
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
			  "xorg-server-xwayland" "slurp" "grim" "grimshot" "swappy" "wlr-randr" "egl-wayland"
			  ;; sway
			  "sway" "swaynotificationcenter" "swaylock" "swayidle" "waybar" "wofi" "wl-clipboard" "clipman"
			  "alacritty"
			  "kanshi" ; automatically switch displays
			  "gammastep" "geoclue" ; could use geoclue, if geoclue was running
			  ;; other desktop related
			  "tumbler" ; D-BUS thumbnail service
			  "poweralertd"
			  "gnome-keyring"
			  "gvfs"
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
			  "pinentry" "pinentry-tty" "gnupg" "openssh" "password-store" "wireguard-tools"
			  "lxappearance" "qt5ct"
			  ;; my desktop apps
			  "nemo" "file-roller" "gvfs" "baobab"
			  "firefox" "icedove" "ungoogled-chromium-wayland"
			  "aqbanking" "gnucash"
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
			  "cheese" "ffmpeg"
			  "obs" ; obs-wlrobs is not necessary, if pipewire is running
			  "simple-scan" "xsane"
			  ;; Virtualization
			  "qemu" "virt-manager"

			  ;;
			  ;; Look & Feel
			  ;; fonts
			  "font-hack"
			  "font-liberation"
			  "font-awesome"
			  "font-dejavu"
			  ;; Nerd-Fonts are installed by M-x nerd-icons-install-fonts
			  ;; all-the-icons are installed by M-x all-the-icons-install-f
			  ;; "font-fira-code" ; needed?
			  "font-google-noto" ; broad range of 
			  "font-google-noto-emoji" ; Emoji support
			  "font-google-noto-serif-cjk" "font-google-noto-sans-cjk" ; chinese fonts
			  "font-microsoft-arial" "font-microsoft-times-new-roman" "font-microsoft-courier-new" ; Microsoft fonts
			  ;; themes
			  "gnome-themes-extra" 
			  ;; icons
			  "adwaita-icon-theme" "elementary-xfce-icon-theme" "hicolor-icon-theme"
			  ))
		   %base-packages))

 ;; Below is the list of system services.  To search for available
 ;; services, run 'guix system search KEYWORD' in a terminal.
 (services
  (append (list
	   (service openssh-service-type)
	   (service bluetooth-service-type)
	   (service cups-service-type
		    (cups-configuration
		     (web-interface? #t)
		     (default-paper-size "A4")))
	   (service tlp-service-type)
	   (service docker-service-type)
	   (service gnome-keyring-service-type)
	   (service screen-locker-service-type
		    (screen-locker-configuration
		     (name "swaylock")
		     (program (file-append swaylock "/bin/swaylock"))
		     (allow-empty-password? #f)
		     (using-pam? #t)
		     (using-setuid? #f)))
	   (service syncthing-service-type
		    (syncthing-configuration
		     (user "flake")))
	   (service libvirt-service-type
		    (libvirt-configuration
		     (unix-sock-group  "libvirt")))
	   (simple-service 'v4l2loopback-options-file etc-service-type
			   (list `("modprobe.d/v4l2loopback.conf"
				   ,(plain-file
				     "v4l2loopback.conf"
				     "options v4l2loopback devices=1 exclusive_caps=1 card_label=\"v4l2loopback\""))))
	   (service kernel-module-loader-service-type  '("v4l2loopback"))
	   (udev-rules-service 'logitech-unify
			       (file->udev-rule
				"42-logitech-unify-permissions.rules"
				(file-append solaar "/share/solaar/udev-rules.d/42-logitech-unify-permissions.rules")))

	   ;; (service geoclue-service-type) 
	   (simple-service 'geoclue-polkit-rule polkit-service-type 
			   (list (file-union
				  "polkit-geoclue"
				  `(("share/polkit-1/rules.d/geoclue.rules"
				     ,(file-append geoclue "/share/polkit-1/rules.d/org.freedesktop.GeoClue2.rules"))))))
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
				       (substitute-urls(append
							(list "https://substitutes.nonguix.org")
							%default-substitute-urls))
				       (authorized-keys (append
							 (list (local-file "./nonguix-signing-key.pub"))
							 %default-authorized-guix-keys)))))))

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))

