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
	     (gnu services cups)
	     (gnu services dbus)
	     (gnu services desktop)
	     (gnu services docker)
	     (gnu services networking)
	     (gnu services pm)
	     (gnu services ssh)
	     (gnu services syncthing)
	     (gnu services virtualization)
	     (gnu services xorg)
	     (gnu packages xfce)
	     (gnu packages networking)
	     (gnu packages shells)
	     (gnu packages wm)
	     (nongnu packages linux)
	     (nongnu system linux-initrd)
	     (guix packages)
	     (guix download)
	     (gnu packages firmware))

;;;
;;; My OS
;;;
(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout (keyboard-layout "de"))
  (host-name "nutbook")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
		 (name "flake")
		 (comment "Julian Flake")
		 (group "users")
		 (home-directory "/home/flake")
		 (shell (file-append zsh "/bin/zsh"))
		 (supplementary-groups '("wheel" "netdev" "audio" "video"
					 "input" "disk" "kvm" "docker" "lp" "lpadmin"
					 "dialout" "libvirt"))) ;; lp is needed for bluetooth
		%base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list
		     (specification->package "fwupd")
		     (specification->package "polkit")
		     (specification->package "flatpak")
		     (specification->package "flatpak-xdg-utils")
		     (specification->package "xdg-desktop-portal")
		     (specification->package "xdg-desktop-portal-gtk")
		     (specification->package "xdg-utils")
		     (specification->package "nss-certs")
		     )
		    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list
	    ;; (service slim-service-type
	    ;; 	    (slim-configuration
	    ;; 	     (xorg-configuration
	    ;; 	      (xorg-configuration (keyboard-layout keyboard-layout)))
	    ;; 	     (display ":0")
	    ;;(vt "vt7")))
	    ;;	   (set-xorg-configuration 
	    ;;	    (xorg-configuration
	    ;;	     (keyboard-layout keyboard-layout)))
            ;; (service screen-locker-service-type
            ;;          (screen-locker-configuration
            ;;           "i3lock" (file-append i3lock "/bin/i3lock") #f))
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
                      "swaylock" (file-append swaylock "/bin/swaylock") #f))
	    (service syncthing-service-type
		     (syncthing-configuration
		      (user "flake")))
	    (service libvirt-service-type
		     (libvirt-configuration
		      (unix-sock-group  "libvirt")))
	    (udev-rules-service 'logitech-unify ; TODO: the file is included in the solaar package and only needs to be copied(?)
				(file->udev-rule
				 "42-logitech-unify-permissions.rules"
				 (let ((git-tag "0.9.2"))
				   (origin
				     (method url-fetch)      
				     (uri (string-append "https://raw.githubusercontent.com/3v1n0/Solaar/"
							 git-tag
							 "/rules.d/42-logitech-unify-permissions.rules"))
				     (sha256
				      (base32 "1hs855fpwls93aab4xhv3kmbx643a4f2mprw0xg4a1gl04dr9jpf"))))))
	    (simple-service 'fwupd-dbus dbus-root-service-type
			    (list fwupd))
	    (simple-service 'fwupd-polkit polkit-service-type
			    (list fwupd))
	    (simple-service 'dbus-extras
			    dbus-root-service-type (list blueman)))
	   ;; This is the (modified) default list of services we are appending to.
	   (modify-services %desktop-services
	     (delete gdm-service-type)
	     (elogind-service-type
	      config => (elogind-configuration
			 (inherit config)
			 (handle-lid-switch-docked 'suspend)))

	     (guix-service-type
	      config => (guix-configuration
			 (inherit config)
			 (substitute-urls(append
					  (list "https://substitutes.nonguix.org")
					  %default-substitute-urls))
			 (authorized-keys (append
					   (list (local-file "./nonguix-signing-key.pub"))
					   %default-authorized-guix-keys)))))))

  (bootloader (bootloader-configuration
	       (bootloader grub-efi-bootloader)
	       (targets (list "/boot/efi"))
	       (keyboard-layout keyboard-layout)))

  (swap-devices (list (swap-space
		       (target (uuid
				"5abe7967-fcb6-4888-8b05-a6413944c60b")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
			 (mount-point "/boot/efi")
			 (device (uuid "FCE6-96C0"
				       'fat32))
			 (type "vfat"))
		       (file-system
			 (mount-point "/")
			 (device (uuid
				  "5c890181-055c-4db3-9a47-2e3769ec24ea"
				  'ext4))
			 (type "ext4"))
		       %base-file-systems))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))

