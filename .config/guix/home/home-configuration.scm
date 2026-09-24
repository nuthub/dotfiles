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
	     "direnv"
	     "bash-completion"	    
	     "python-pygments" ; zsh plugin colorize needs this. Alternative: go-chroma
	     "screen"
	     ;; notebook tools
	     "power-profiles-daemon" "powertop"
	     "acpi"
	     "brightnessctl"
	     ;; basics
	     "mailutils" ; rottlog seems to need this
	     "git" "git:send-email" "git:gui" "git-delta"
	     ;; emacs & related
	     "isync" "mu" "goimapnotify" "emacs-mu4e-walk"
	     "emacs-pgtk" "emacs-pdf-tools" "emacs-vterm" "emacs-eat"
	     "emacs-guix" "emacs-geiser" "emacs-geiser-guile"
	     "emacs-org-superstar" "emacs-org-contrib" "emacs-ox-hugo" "emacs-org-pomodoro" "emacs-org-roam" "emacs-org-roam-ui" 
	     "emacs-rainbow-delimiters"
	     "emacs-modus-themes"
	     "emacs-exiftool"
	     "emacs-vertico" "emacs-orderless" "emacs-consult" "emacs-corfu" "emacs-marginalia" "emacs-embark" "emacs-vundo" "emacs-aggressive-indent"
	     "emacs-openwith" "emacs-terminal-here"
	     "emacs-frames-only-mode" "emacs-winum"
	     "emacs-highlight-indent-guides" "emacs-yasnippet" "emacs-yasnippet-snippets"
	     "emacs-khalel" "emacs-khardel"
	     "emacs-nerd-icons" "emacs-nerd-icons-corfu" "emacs-nerd-icons-dired" "emacs-ligature" "emacs-auto-dark" "emacs-smartparens"
	     "emacs-magit" "emacs-forgejo" "emacs-agitjo" "emacs-git-gutter" "emacs-git-gutter-fringe"
	     "emacs-dired-open-with"
	     "emacs-treesit-auto" "emacs-combobulate"
	     "emacs-lsp-mode" "emacs-lsp-ui"
	     "emacs-all-the-icons" "emacs-all-the-icons-dired" "emacs-all-the-icons-completion"
	     "emacs-olivetti" "emacs-gt" "emacs-jinx" "enchant" "emacs-flymake-languagetool"
	     "emacs-citar" "emacs-citar-org-roam" "emacs-biblio" "emacs-auctex"
	     "emacs-gnuplot" "gnuplot"
	     "emacs-engrave-faces"
	     "emacs-htmlize"
	     "emacs-gptel" "emacs-posframe" "emacs-gptel-quick"
	     "emacs-ement"
	     "grip" ; needed for grip-mode (Markdown Preview by GitHub)
	     ;; "make" "perl" "texinfo" ; building auctex for elpaca needs these
	     "emacs-web-mode" "emacs-php-mode" "emacs-markdown-mode" "emacs-grip-mode" "emacs-yaml-mode" "emacs-plantuml-mode" "emacs-nov"
	     "emacs-ttl-mode" "emacs-ttl-ts-mode"
	     "emacs-cypher-ts-mode"
	     ;; Tree-Sitter grammars
	     ;; for emacs-treesit a grammar is a requirement but not sufficient
	     ;; there needs to be a corresponding major mode (~-ts-mode~)
	     "tree-sitter-css"
	     "tree-sitter-go"
	     "tree-sitter-html"
	     "tree-sitter-java"
	     "tree-sitter-javascript"
	     "tree-sitter-json"
	     ;; "tree-sitter-cypher" ; no quix package yet
	     "tree-sitter-just" ; not yet in guix, PR pending
	     "emacs-just-ts-mode" 
	     "tree-sitter-markdown"
	     "tree-sitter-plantuml"
	     "tree-sitter-python"
	     "tree-sitter-rust"
	     "tree-sitter-toml"
	     "tree-sitter-typescript"
	     "tree-sitter-yaml"
	     ;; Programming languages
	     "openjdk@25:jdk" ; java-lsp wants this, otherwise I'd just use it in guix shells only
	     "efibootmgr"
	     "bind:utils" ; for dig
	     "cups" ; for lpq command
	     "file"
	     "hugo" ; for nuthouse, from nonguix
	     "btop" "htop" "s-tui"
	     "jq" ; needed by sway / zoom
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
	     ;; sway
	     ;; sway needs/likes gtk + wlr portals
	     "xdg-desktop-portal-gtk"
	     "xdg-desktop-portal-wlr"
	     "sway"
	     "swayidle"
	     "swaylock"
	     "waybar"
	     "swaybg"
	     "dex"
	     "rofi"
	     "dunst" ; alternatives: "mako" "swaynotificationcenter"
	     "libnotify" ; for notify-send command
	     ;; compatibility
	     "qt5ct" "qtwayland@5" ; at least nextcloud-client needs this (2024-11-28)
	     "qt6ct" ; "qtwayland@6"
	     ;; output management
	     "wdisplays"
	     "kanshi" ; automatically switch displays
	     "wlsunset"
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
	     "pinentry" "pinentry-tty" "pinentry-emacs" "pinentry-gnome3" "openssh"
	     "wireguard-tools"
	     "lxqt-policykit"

	     ;; my desktop apps
	     "gvfs" "nemo" "file-roller" "baobab"
	     "firefox" "librewolf"
	     "icecat" "ungoogled-chromium-wayland" ; https://codeberg.org/guix/guix/issues/1465#issuecomment-5928124
	     "icedove-wayland" ; thunderbird
	     "aqbanking" "gnucash"

	     ;; media
	     "inkscape" "graphviz"
	     "mpv" "imv"
	     "gimp"
	     "imagemagick" "optipng"
	     "wf-recorder" "obs" "handbrake" "snapshot" ; obs-wlrobs is not necessary, if pipewire is running ; snapshot replaces cheese

	     ;; Virtualization & Containerization
	     "qemu" "virt-manager" "ovmf-x86-64"
	     "podman" "podman-compose"

	     ;; Theme
	     "gnome-themes-extra" ; (contains gtk2 and gtk3 variants of Adwaita)
	     
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
	     ;; I installed (and updated) them via
	     ;;    wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
	     "adwaita-icon-theme" ; Gimp (and probably others) use some icons that are missing from Papirus (e.g. bold, italic, underline icons in text tool)
	     "hicolor-icon-theme" ; waybar/privacy uses icons from here
	     ;; Cursors
	     "xcursor-themes" "bibata-cursor-theme"

	     ;; Office
	     "aspell"
	     "aspell-dict-de"
	     "aspell-dict-en" ; aspell or hunspell? Good question

	     ;; PDFPC + gstreamer packages for playong embedded videos
	     "pdfpc"
	     "gstreamer" "gst-plugins-base" "gst-plugins-good"
	     "gst-plugins-bad" "gst-plugins-ugly"

	     ;; Further document processing
	     "pandoc"
	     "ghostscript" ; for e.g. ps2pdf
	     "stapler"
	     "mupdf" "poppler"

	     ;; Finally a "modern" office
	     "libreoffice"))) 

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list
   (simple-service 'some-useful-env-vars-service
		   home-environment-variables-service-type
		   `(("EDITOR" . "emacsclient -nc")
                     ("TERMINAL" . "alacritty")
		     ;; I am on wayland and don't want back to X11
		     ;; some of the wayland env variables are explained here:
		     ;; https://discourse.ubuntu.com/t/environment-variables-for-wayland-hackers/12750
		     ("XDG_BACKEND" . "wayland")
		     ("QT_QPA_PLATFORM" . "wayland")
		     ("QT_QPA_PLATFORMTHEME" ."qt6ct")
		     ("MOZ_ENABLE_WAYLAND" . "1")
                     ("_JAVA_AWT_WM_NONREPARENTING" . "1")))
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
			   	    '("goimapnotify" "-wait" "5"))) ; wait in config is ignored (2026-09-18 with 2.5.4)
			  (stop #~(make-kill-destructor)))))
   (simple-service 'languagetool home-shepherd-service-type
		   (list (shepherd-service
                          (documentation "Run the LanguageTool server.")
			  (provision '(languagetool))
                          (auto-start? #t)
			  (respawn? #t)
			  (respawn-delay 60)
			  (start #~(make-forkexec-constructor
			   	    '("java" "-cp"
				      "/home/flake/opt/LanguageTool/languagetool-server.jar"
				      "org.languagetool.server.HTTPServer"
				      "--config" "/home/flake/opt/LanguageTool/server.properties"
				      "--port" "8081"
				      "--allow-origin" "\"*\"")))
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
             (latitude 51.4) (longitude 7.1))) ; Recklinghausen
	     ;; (latitude 51.6) (longitude 3.5))) ; Oostkapelle
   (service home-batsignal-service-type)
   (service home-dbus-service-type)
   (service home-pipewire-service-type)
   ;; Guix home writes an own fonts.conf anyways to include fonts installed on home profile.
   ;; Therefore, I need to hook into that and can't use my own fonts.conf from dotfiles.
   ;;
   ;; Additionally, I set the same fonts via gsettings, emacs uses them:
   ;; gsettings set org.gnome.desktop.interface document-font-name 'Noto Serif 11'
   ;; gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
   ;; gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Code 11'
   ;; This is set with other gsettings in ~/.local/share/[dark|light]-mode.d/gsettings.sh,
   ;; although the fonts are independent from light / dark mode.
   (simple-service 'default-fonts
		   home-fontconfig-service-type
		   (list
		    '(match (edit (@ (mode "assign") (name "antialias"))
				  (bool "true")))
		    '(match (edit (@ (mode "assign") (name "hinting"))
				  (bool "true"))) ; false to disable
		    '(match (edit (@ (mode "assign") (name "hintstyle"))
				  (const "hintslight"))) ; was hintnone 
		    '(alias (family "sans-serif")
			    (prefer (family "Noto Sans")
				    (family "Font Awesome 6 Free")
				    (family "Symbols Nerd Font")
				    (family "Noto Color Emoji")))
		    '(alias (family "serif")
			    (prefer (family "Noto Serif")
				    (family "Symbols Nerd Font")
				    (family "Font Awesome 6 Free")
				    (family "Noto Color Emoji")))
		    '(alias (family "monospace")
			    (prefer (family "Fira Code")
				    (family "Symbols Nerd Font")
				    (family "Font Awesome 6 Free")
				    (family "Noto Color Emoji")))
		    '(alias (family "icon")
			    (prefer (family "Symbols Nerd Font")
				    (family "Font Awesome 6 Free"))))))))


