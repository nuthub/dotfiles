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

   (simple-service 'some-useful-env-vars-service
		   home-environment-variables-service-type
		   `(("PATH" . "$HOME/.local/bin:$PATH")
		     ("TERMINAL" . "alacritty")
		     ("EDITOR" . "emacsclient")
		     ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/flake/.local/share/flatpak/exports/share")
		     ;;		     ("QT_QPA_PLATFORMTHEME" . "qt5ct")
		     ;;		     ("XDG_CURRENT_DESKTOP" . "sway")
		     ;;		     ("XDG_SESSION_DESKTOP" . "sway")
		     ;;		     ("QT_QPA_PLATFORM" . "sway")
		     ;;              ("MOZ_ENABLE_WAYLAND" . "1")
		     )))))
