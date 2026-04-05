(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
	     (gnu home services)
	     (gnu home services desktop)
	     (gnu home services dotfiles)
             (gnu home services fontutils)
             (gnu home services pm)
	     (gnu home services mcron)
;;	     (gnu home services niri)
             (gnu home services shells)
	     (gnu home services shepherd)
	     (gnu home services sound))

(home-environment
 (packages (specifications->packages
  	    (list
	     "zsh"
	     "zsh-autosuggestions"
	     "zsh-completions"
	     "zsh-syntax-highlighting"
	     "zsh-autopair"
	     "bash-completion"
	     "python-pygments" ; zsh plugin colorize needs this. Alternative: go-chroma
	     ;; notebook tools
	     "power-profiles-daemon" "powertop"
	     "acpi"
	     "brightnessctl"
	     "modem-manager" "libmbim" ; "modem-manager-fcc-auto-unlock" ; package auto-unlock has no effect?
	     ;; "my-modem-manager" "libmbim"

	     ;; basics
	     "mailutils" ; rottlog seems to need this
	     "git" "git:send-email" "git:gui" "git-delta"
	     ;; emacs & related
	     "emacs-pgtk" "emacs-pdf-tools" "emacs-vterm" "emacs-jinx" "enchant" "python-proselint" "gnuplot" ; enchant is needed by jinx; "emacs-pgtk-xwidgets"
	     "make" "perl" "texinfo" ; building auctex for elpaca needs these
	     "isync" "mu" "goimapnotify"

	     ;; Programming languages
	     
	     "openjdk@25:jdk" ; java-lsp wants this, otherwise I'd just use it in guix shells only
	     "efibootmgr"
	     "bind:utils" ; for dig
	     "cups" ; for lpq command
	     "file"
	     "hugo" ; for nuthouse, from nonguix
	     "btop" "htop" "s-tui"
	     "jq" ; needed by sway / zoom
	     "just"
	     "neofetch"
	     "net-tools" ; for ifconfig  netstat  route
	     "nmap"
	     "bc"
	     "octave"
	     "ripgrep"
	     "trash-cli"
	     "tree"
	     "unzip"
	     "7zip"
	     "subversion"
	     "usbutils"
	     "watchexec"
	     
	     ;; base
	     "flatpak"
	     "alacritty"

	     ;; XDG
	     "xorg-server-xwayland"
	     "xwayland-satellite"
	     "xdg-utils" "xdg-user-dirs"
	     ;; sway and niri need gtk
	     "xdg-desktop-portal-gtk"
	     ;; sway likes wlr
	     "xdg-desktop-portal-wlr"
	     ;; niri likes gnome
	     "xdg-desktop-portal-gnome"
	     ;; sway+niri
	     "sway"
	     "niri"
	     "dex"
	     "waybar"
	     "swaybg"
	     "rofi"
	     "swaylock"
	     "swayidle"
	     "swaynotificationcenter" ; "dunst"
	     "libnotify"
	     "wob" ; OSD overlay
	     ;; compatibility
	     "qt5ct"
	     "qtwayland@5" ; at least nextcloud-client needs this (2024-11-28)
	     
	     ;; output management
	     "wdisplays"
	     "kanshi" ; automatically switch displays
	     "gammastep" ; could use geoclue, if geoclue was running
	     "wl-mirror" ; mirror the desktop, e.g. to a beamer

	     ;; screenshots & clipboard management
	     "slurp"
	     "grim"
	     "swappy" ; screenshots, satty missing in guix
	     "wl-clipboard"
	     "cliphist"
	     "wtype" ; wofi-emoji needs wtype
	     "espanso-wayland"

	     ;; other desktop related
	     "tumbler" ; D-BUS thumbnail service
	     "gnome-keyring" ; used by nextcloud client

	     ;; connectivity / media
	     "pipewire"
	     "wireplumber"
	     "pavucontrol"
	     "bluez"
	     "blueman"
	     "udiskie"
	     "solaar"
	     ;; syncing and versioning
	     "binutils" ; for ar command
	     "davfs2" "glib:bin" ; has gio which allows to mount davfs as user
	     "nextcloud-client"
	     "zip"
	     "mosquitto" ;; for doorstatus in waybar
	     
	     ;; PIM
	     "pimsync"
	     "khal"
	     "khard"

	     ;; security
	     "pinentry" "pinentry-tty" "pinentry-emacs" "openssh"
	     "wireguard-tools"
	     "lxqt-policykit"

	     ;; my desktop apps
	     "gvfs" "nemo" "file-roller" "baobab"
	     "firefox" "librewolf"
	     "icecat" "ungoogled-chromium-wayland" ; https://codeberg.org/guix/guix/issues/1465#issuecomment-5928124
	     ;; "icedove-wayland" ; thunderbird
	     "aqbanking" "gnucash"

	     ;; media
	     "inkscape" "graphviz"
	     "mpv" "imv"
	     "gimp"
	     "imagemagick" "optipng"
	     "wf-recorder" "obs" "handbrake" "cheese" ; obs-wlrobs is not necessary, if pipewire is running

	     ;; Virtualization & Containerization
	     "qemu" "virt-manager" "ovmf-x86-64"
	     "podman" "podman-compose"

	     ;; Theme
	     "orchis-theme" ; successor of materia-theme

	     ;; fonts
	     ;; Nerd-Fonts are installed by M-x nerd-icons-install-fonts into .local/share/fonts
	     ;; all-the-icons are installed by M-x all-the-icons-install-fonts into .local/share/fonts
	     "font-google-noto" ; broad range of fonts
	     "font-google-noto-emoji" ; Emoji support
	     "font-google-noto-serif-cjk" "font-google-noto-sans-cjk" ; chinese fonts
	     "font-fira-code" ; "font-hack" is also nice, but doesn't support ligatures
	     "font-awesome-nonfree" ; some icons, from nonguix, fontawesome in guix is an outdated version: https://issues.guix.gnu.org/32916
	     "font-microsoft-arial" "font-microsoft-times-new-roman" "font-microsoft-courier-new" ; Microsoft fonts

	     ;; Icons:
	     ;; my primary icon theme is Papirus(-Dark)
	     ;; "papirus-icon-theme" ; disabled in system profile (see below)
	     ;; I manually installed papirus-icon-theme in my $HOME/.icons directory for two reasons:
	     ;;   1. flatpak apps take ages to start with Papirus-Icon-Theme in system's profile
	     ;;   2. it uses a lot of inodes: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/issues/3563 and https://issues.guix.gnu.org/68561 This becomes an issue with frequently reconfigured profiles
	     "hicolor-icon-theme" ; waybar/privacy uses icons from here
	     ;; Cursors
	     "xcursor-themes" "bibata-cursor-theme"
	     ;; Office
	     "aspell"
	     "aspell-dict-de"
	     "aspell-dict-en" ; aspell or hunspell? Good question
	     "texlive-scheme-medium"
	     "emacs-org-texlive-collection"
	     "texlive-amsfonts" ;; should be included in "emacs-org-texlive-collection", used for [-] in check lists
	     "texlive-latexmk" ; should be in emacs-org-texlive-collection
	     "texlive-biber"
	     "texlive-collection-latexextra"
	     "texlive-collection-fontsextra" ;; beamer theme koblenz needs opensans
	     "texlive-collection-pictures"
	     "pandoc"
	     "ghostscript" ;; for e.g. ps2pdf
	     "stapler"
	     "mupdf" "poppler"
	     ;; PDFPC packages + gstreamer packages for embedding videos in presentations
	     "pdfpc"
	     "texlive-pdfpc"
	     "gstreamer" "gst-plugins-base" "gst-plugins-good"
	     "gst-plugins-bad" "gst-plugins-ugly"
	     ;; "modern" office
	     "libreoffice")))
 

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list
   (simple-service 'some-useful-env-vars-service
		   home-environment-variables-service-type
		   `(("EDITOR" . "emacsclient -nc")
                     ("TERMINAL" . "alacritty")
		     ("MOZ_ENABLE_WAYLAND" . "1")
                     ("_JAVA_AWT_WM_NONREPARENTING" . "1")
		     ;; ("GTK_THEME" . "Materia-dark")
		     ))
   (service home-zsh-service-type
	    (home-zsh-configuration
	     (zshrc (list (local-file "zshrc")))
	     (zprofile (list (local-file "zprofile")))))
   ;; (service home-niri-service-type)
   (simple-service 'goimapnotify home-shepherd-service-type
		   (list (shepherd-service
                          (documentation "Run the goimapservice daemon.")
			  (provision '(goimapnotify))
                          (auto-start? #f)
			  (respawn? #t)
			  (respawn-delay 60)
			  (start #~(make-forkexec-constructor
			   	    '("goimapnotify")))
			  (stop #~(make-kill-destructor)))))
   (simple-service 'pimsync home-shepherd-service-type
		   (list (shepherd-service
                          (documentation "Run the pimsync daemon.")
			  (provision '(pimsync))
                          (auto-start? #t)
			  (respawn? #t)
			  (respawn-delay 60)
			  (start #~(make-forkexec-constructor
			   	    '("pimsync" "daemon")))
			  (stop #~(make-kill-destructor)))))
   (simple-service 'mbsync home-shepherd-service-type
		   (list (shepherd-service
                          (documentation "Run \"mbsync -a\" once.")
			  (provision '(mbsync))
			  (auto-start? #f)
                          (respawn? #f)
                          (one-shot? #t)
			  (start #~(make-forkexec-constructor
				    '("mbsync" "-a")))
			  (stop #~(make-kill-destructor)))))
   (service home-mcron-service-type
	    (home-mcron-configuration
	     (jobs (list
		    #~(job "5,15,25,35,45,55 * * * *" "/home/flake/.local/bin/create-calendar.org.sh")
		    #~(job "0,10,20,30,40,50 * * * *" "mbsync -a")))))
   (service home-darkman-service-type
            (home-darkman-configuration
             (latitude 51.4)
             (longitude 7.1)))
   (service home-batsignal-service-type)
   (service home-dbus-service-type)
   (service home-pipewire-service-type)
   ;; Guix home writes an own fonts.conf anyways to include fonts installed on home profile.
   ;; Therefore, I need to hook into that and can't use my own fonts.conf from dotfiles.
   ;; Additionally, I set the same fonts via gsettings:
   ;; gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
   ;; gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Code 11'
   (simple-service 'default-fonts
		   home-fontconfig-service-type
		   (list
		    '(match (edit (@ (mode "assign") (name "antialias"))
				  (bool "true")))
		    '(match (edit (@ (mode "assign") (name "hinting"))
				  (bool "true"))) ; false to disable
		    '(match (edit (@ (mode "assign") (name "hintstyle"))
				  (const "hintslight"))) ; was hintnone 
		    '(alias (family "monospace")
			    (prefer (family "Fira Code")
				    (family "Font Awesome 6 Free")
				    (family "Noto Color Emoji")))
		    '(alias (family "sans-serif")
			    (prefer (family "Noto Sans")
				    (family "Font Awesome 6 Free")
				    (family "Noto Color Emoji")))
		    '(alias (family "serif")
			    (prefer (family "Noto Serif")
				    (family "Font Awesome 6 Free")
				    (family "Noto Color Emoji")))
		    '(alias (family "icon")
			    (prefer (family "Font Awesome 6 Free"))))))))


