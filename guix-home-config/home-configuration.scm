;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages (list
				      "acpi"
                                      "alacritty"
				      "aqbanking"
				      "arandr"
				      "aspell"
				      "aspell-dict-de"
				      "aspell-dict-en"
				      "autorandr"
				      "baobab"
				      "bind" ;;for dig
				      "borg"
				      "brightnessctl"
				      "cheese"
				      "curl"
				      "dia"
				      "docker"
				      "docker-compose"
				      "dunst"
				      "emacs"
				      "emacs-pdf-tools"
				      "feh"
				      "file"
				      "flameshot"
				      "flatpak"
				      "ffmpeg"
				      "font-abattis-cantarell"
				      "font-awesome"
				      "font-fira-code"
				      "font-google-noto-sans-cjk"
				      "font-hack"
				      "font-liberation"
				      "gcc" ;; for emacs (emacssql compilation)
				      "gimp"
				      "git"
				      "gnome-keyring"
				      "gnucash"
				      "gnupg"
				      "guix-icons"
				      "i3lock"
				      "icecat"
				      "icedove"
				      "imagemagick"
				      "inkscape"
				      "isync"
				      "libreoffice"
				      "libnotify" ;; desktop notification
				      "lxappearance"
				      "maven"
				      ;;				      "modem-manager"
				      "mosquitto"
				      "mpv"
				      "mu"
				      "neofetch"
				      "nextcloud-client"
				      "nmap"
				      "ntp" ;; does it work ??
				      "obs"
				      "octave"
				      "openssh"
				      "optipng"
				      "pandoc"
				      "password-store"
				      "pasystray"
				      "pcmanfm"
				      "pdfpc"
				      "pinentry-qt"
				      "polybar"
				      "powertop"
				      "ripgrep"
				      "ristretto"
				      "rofi"
				      "rsync"
				      "seahorse"
				      "simple-scan"
				      "solaar"
				      "sqlite" ;; for org-roam
				      "stapler"
				      "stow"
				      "subversion"
				      "syncthing"
				      "sxiv"
				      "trash-cli"
				      "tree"
				      "tumbler"
				      "udiskie"
				      "unzip"
				      "usbutils"
				      "wireguard-tools"
				      "yt-dlp"
				      "xev"
				      "xkill"
				      "xmessage" ;; ??
				      "xprop"
				      "xsane"
				      "xss-lock"
				      "zathura"
				      "zsh"
				      )))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                             ("ls" . "ls -p --color=auto")))
                  (bashrc (list (local-file
                                 "/home/flake/guix/guix-home-config/.bashrc"
                                 "bashrc")))
                  (bash-profile (list (local-file
                                       "/home/flake/guix/guix-home-config/.bash_profile"
                                       "bash_profile"))))))))
