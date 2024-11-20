;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
	     (gnu home services)
	     (gnu home services desktop)
	     (gnu home services dotfiles)
             (gnu home services fontutils)
	     (gnu home services mcron)
             (gnu home services shells)
	     (gnu home services syncthing)
	     (gnu home services sound))

;; home services
;; https://guix.gnu.org/manual/devel/en/html_node/Home-Services.html
;; https://git.ditigal.xyz/~ruther/guix-config/tree/main/item/home/home-configuration.scm
;; Home Environments

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 ;; (packages (specifications->packages
 ;; 	    (list
 ;; 	     "flatpak"
 ;; 	     "flatpak-xdg-utils")))
 
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
		     ("GTK_THEME" . "Materia-dark")))
   (service home-zsh-service-type
	    (home-zsh-configuration
	     (zshrc (list (local-file "zshrc")))
	     (zprofile (list (local-file "zprofile")))))
   ;; (service home-dotfiles-service-type
   ;;          (home-dotfiles-configuration
   ;;           (directories '("dotfiles"))))
   ;; (service home-xdg-configuration-files-service-type
   ;; 	    `(("test/test.org" ,(local-file "./dotfiles/test.org"))))

   (service home-syncthing-service-type)
   ;;   (service home-dbus-service-type)
   ;;   (service home-pipewire-service-type)
   (service home-mcron-service-type
	    (home-mcron-configuration
	     (jobs (list
		    #~(job "0 * * * *"
			   "/home/flake/.local/bin/sync-calendars.sh -f")
		    #~(job "10,20,30,40,50 * * * *"
			   "/home/flake/.local/bin/sync-calendars.sh -l")
		    #~(job "5,15,25,35,45,55 * * * *"
			   "mbsync -a"))))) ; as a root mcron job, more needs to be done
   ;; Guix home writes an own fonts.conf anyways to include fonts installed on home profile. Therefore, I need to hook into that and can't use my own fonts.conf from dotfiles.
   (simple-service 'default-fonts
		   home-fontconfig-service-type
		   (list
		    '(match (edit (@ (mode "assign") (name "antialias"))
				  (bool "true")))
		    '(match (edit (@ (mode "assign") (name "hinting"))
				  (bool "false")))
		    '(match (edit (@ (mode "assign") (name "hintstyle"))
				  (const "hintnone")))
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


