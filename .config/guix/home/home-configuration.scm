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
	     (gnu home services sound)
	     (gnu home services syncthing))

(home-environment
  (packages (specifications->packages
  	     (list
  	      "flatpak")))

  
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
    (simple-service 'goimapnotify home-shepherd-service-type
		    (list (shepherd-service
                           (documentation "Run the goimapservice daemon.")
			   (provision '(goimapnotify))
                           (auto-start? #f)
			   (respawn? #f)
			   (start #~(make-forkexec-constructor
				     '("goimapnotify")))
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
    (service home-zsh-service-type
	     (home-zsh-configuration
	      (zshrc (list (local-file "zshrc")))
	      (zprofile (list (local-file "zprofile")))))

    (service home-batsignal-service-type)
    (service home-syncthing-service-type)
    (service home-dbus-service-type)
    (service home-pipewire-service-type)
    (service home-mcron-service-type
	     (home-mcron-configuration
	      (jobs (list
		     #~(job "0 * * * *"
			    "/home/flake/.local/bin/sync-calendars.sh -f")
		     #~(job "15,30,45 * * * *"
			    "/home/flake/.local/bin/sync-calendars.sh -l")
		     #~(job "10 * * * *"
			    "mbsync -a")))))
    ;; Guix home writes an own fonts.conf anyways to include fonts installed on home profile. Therefore, I need to hook into that and can't use my own fonts.conf from dotfiles.
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


