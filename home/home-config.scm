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
 (packages (specifications->packages
	    (list
	     ;; XDG
	     "xdg-desktop-portal" "xdg-desktop-portal-gtk" "xdg-utils"
	     ;; i3
	     ;; "i3-wm"
	     ;; ;; default i3 config packages
	     ;; "i3status"
	     ;; "alacritty"
	     ;; "dmenu"
	     ;; "polybar"
	     ;; "dunst"
	     ;; "picom"
	     ;; "rofi"
	     ;; "libnotify"
	     ;; "xss-lock" ;; i3lock is installed via screen-locker-service-type
	     ;; x tools
	     "xev"
	     "xkill"
	     "xprop"
	     "xrdb"
	     "xrandr"
	     ;; wayland
	     "xorg-server-xwayland" "pipewire" "wireplumber" "slurp" "xdg-desktop-portal-wlr" "grim"
	     ;; sway
	     "sway" "swayidle" "waybar" "rxvt-unicode" "alacritty" "wofi" "swaynotificationcenter" ;; swaylock is installed via screen-locker-service-type
	     ;; polkit / udev / xdg / dbus / gvfs
	     "polkit-gnome" ;; used?
	     "tumbler" ;; D-BUS thumbnail service
	     "poweralertd"
	     "gnome-keyring"
	     "gvfs"
	     ;; my personal config
	     "feh"
	     "mosquitto" ;; for doorstatus in polybar
	     "acpi"
	     "brightnessctl"
	     ;; connectivity / media
	     "blueman" 
	     "pasystray"
	     "pavucontrol"
	     "pulseaudio"
	     "udiskie"
	     "solaar"
	     ;; other sources / hubs
	     "flatpak"
	     "flatpak-xdg-utils"
	     "docker" ;; "docker-compose"
	     ;; my shell and shell tools
	     "zsh" "zsh-autosuggestions" "zsh-syntax-highlighting"
	     "cups" ;; to have commands like lpq etc
	     "file"
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
	     ;; emacs & related
	     "emacs-next" "emacs-pdf-tools"
	     "isync" "mu"
	     ;; security
	     "pinentry" "pinentry-tty" "gnupg" "openssh" "password-store" "wireguard-tools"
	     ;; x basics
	     "arandr" "autorandr"
	     "lxappearance"
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
	     ;; themes
	     "gnome-themes-extra" "matcha-theme" "arc-theme" "materia-theme" ;; don't show up in lxappearance without ln -s /home/flake/.guix-home/profile/share/themes ~/.themes
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
	     ;; icons
	     "adwaita-icon-theme" "elementary-xfce-icon-theme"
	     ;; syncing and versioning
	     "samba"
	     "binutils" ;; for ar command
	     "borg"
	     "curl"
	     "git" "git:gui" "git:send-email"
	     "rsync"
	     "subversion"
	     "syncthing"
	     "nextcloud-client"
	     "yt-dlp"
	     "zip"
	     ;; media
	     ;; "dia"
	     "inkscape" "graphviz"
	     "flameshot" "ristretto" "sxiv" "gimp"
	     "imagemagick" "optipng"
	     "cheese" "ffmpeg" "mpv" "obs"
	     "simple-scan" "xsane"
	     ;; Virtualization
	     "qemu" "virt-manager"
	     ;; for my java shells
	     "hicolor-icon-theme" "libxtst"
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
   (service home-dbus-service-type) ;; This is the service type for running a session-specific D-Bus, for unprivileged applications that require D-Bus to be running. -> flatpak?

   ;; (simple-service 'nutguix-packages-service
   ;;                 home-channels-service-type
   ;;                 (list
   ;;                  (channel
   ;;                   (name 'nutguix)
   ;;                   (url "https://github.com/nuthub/nutguix.git")
   ;; 		     (branch "main"))))
   (simple-service 'some-useful-env-vars-service
		   home-environment-variables-service-type
		   `(("TERMINAL" . "alacritty")
		     ("EDITOR" . "emacsclient")
		     ("XDG_CURRENT_DESKTOP" . "sway")
		     ("XDG_SESSION_DESKTOP" . "sway")
		     ("QT_QPA_PLATFORM" . "sway")
		     ("QT_QPA_PLATFORMTHEME" . "qt5ct")
		     ("MOZ_ENABLE_WAYLAND" . "1")
		     ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/flake/.local/share/flatpak/exports/share")
		     ("PATH" . "$HOME/.local/bin:$PATH"))))))
