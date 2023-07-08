;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu home services)
	     (gnu home services desktop)
	     (gnu home services shells)
	     (gnu home services guix)
	     (gnu packages)
	     (gnu services)
	     (gnu packages xdisorg)
	     (guix gexp))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 ;; (packages (specifications->packages
 ;; 	    (list)))
 (packages (specifications->packages
	    (list
	     ;; the following can be moved to home profile (once again)
	     ;; my shell and shell tools
	     "zsh" "zsh-autosuggestions" "zsh-syntax-highlighting"
	     "cups" ;; to have commands like lpq etc
	     "file"
	     "efibootmgr"
	     "htop"
	     "neofetch"
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
	     "xbacklight"
	     ;; syncing and versioning
	     "samba"
	     "binutils" ;; for ar command
	     "curl"
	     "borg"
	     "rsync"
	     "subversion"
	     "syncthing"
	     ;; "git:gui" "git:send-email"
	     "nextcloud-client"
	     "yt-dlp"
	     "zip"
	     ;; XDG
	     "xdg-utils"
	     ;; I need all of these portals, I think
	     "xdg-desktop-portal" "xdg-desktop-portal-gtk" "xdg-desktop-portal-wlr"
	     ;; wayland, not sure what I really need
	     "xorg-server-xwayland" "qtwayland@5.15.8" "pipewire" "wireplumber" "slurp" "grim" "grimshot" "swappy" "wlr-randr" "egl-wayland" ; qtwayland@6.3.2
	     ;; sway
	     "sway" "swayidle" "waybar" "rxvt-unicode" "alacritty" "wofi" "swaynotificationcenter" "swaylock"
	     ;; other desktop related
	     "tumbler" ; D-BUS thumbnail service
	     "poweralertd"
	     "gnome-keyring"
	     "gvfs"
	     "feh"
	     "mosquitto" ;; for doorstatus in polybar
	     ;; connectivity / media
	     "blueman" 
	     "pasystray"
	     "pavucontrol"
	     "pulseaudio"
	     "udiskie"
	     "solaar"
	     ;; other sources / hubs
	     "flatpak"
	     "docker"
	     ;; emacs & related
	     "emacs-next-pgtk" "emacs-pdf-tools" ; emacs-next
	     "isync" "mu"
	     ;; security
	     "pinentry" "pinentry-tty" "gnupg" "openssh" "password-store" "wireguard-tools"
	     "lxappearance" "qt5ct"
	     ;; my desktop apps
	     "feh" "zathura" "mpv" "pcmanfm" "file-roller" "gvfs" "baobab"
	     "seahorse"
	     "firefox" "icedove" "ungoogled-chromium"
	     "aqbanking" "gnucash"
	     "libreoffice"
	     ;; Office, LaTeX, PDF & Co
	     "aspell"
	     "aspell-dict-de"
	     "aspell-dict-en"
	     "pandoc"
	     "pdfpc"
	     "stapler"
	     "texlive" "biber" ;; JabRef is installed via flatpak
	     ;; media
	     "inkscape" "graphviz"
	     "flameshot" "ristretto" "sxiv" "gimp"
	     "imagemagick" "optipng"
	     "cheese" "ffmpeg" "mpv"
	     ;; obs
	     "simple-scan" "xsane"
	     ;; Virtualization
	     "qemu" "virt-manager"
	     ;; for my java shells
	     "hicolor-icon-theme" "libxtst"
	     ;; fonts
	     "font-abattis-cantarell"
	     "font-awesome"
	     "font-dejavu"
	     "font-fira-code"
	     "font-google-noto-sans-cjk"
	     "font-hack"
	     "font-liberation"
	     "font-microsoft-arial"
	     "font-microsoft-times-new-roman"
	     "font-microsoft-courier-new"
	     "font-openmoji"
	     ;; themes
	     "gnome-themes-extra" "matcha-theme" "arc-theme" "materia-theme"
	     ;; icons
	     "adwaita-icon-theme" "elementary-xfce-icon-theme"
	     ;; 
	     ;; Xorg & i3 (we can get rid of it, once wayland is more feature complete)
	     ;;	     "xorg-server" "xinit"
	     "i3-wm" "polybar" "i3status" "alacritty" "dmenu" "polybar" "dunst" "picom" "rofi" "libnotify" "i3lock" "xss-lock" ;; i3lock is installed via screen-locker-service-type
	     ;; x tools
	     "arandr" "autorandr"
	     "xev"
	     "setxkbmap"
	     "xkill"
	     "xprop"
	     "xrdb"
	     "xrandr"
	     )))
 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list

   ;;(service home-bash-service-type)

   (service home-zsh-service-type
	    (home-zsh-configuration
	     (zprofile
	      (list (local-file "/home/flake/.config/guix/home/zprofile" "zprofile")))))

   (service home-dbus-service-type)

   (simple-service 'some-useful-env-vars-service
		   home-environment-variables-service-type
		   `(("PATH" . "$HOME/.local/bin:$PATH")
		     ("TERMINAL" . "alacritty")
		     ("EDITOR" . "emacsclient")
		     ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/flake/.local/share/flatpak/exports/share"))))))
