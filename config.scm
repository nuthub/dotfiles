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
	     (guix packages)
	     (guix download))
(use-service-modules cups dbus desktop docker networking ssh syncthing xorg)

(use-modules (nongnu packages linux)
	     (nongnu system linux-initrd))

(define %logitech-unify-udev-rules
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
		(supplementary-groups '("wheel" "netdev" "audio" "video" "input" "disk" "docker" "lpadmin" "dialout")))
	       %base-user-accounts))

 ;; Packages installed system-wide.  Users can also install packages
 ;; under their own account: use 'guix search KEYWORD' to search
 ;; for packages and 'guix install PACKAGE' to install a package.
 (packages (append (list (specification->package "i3-wm")
			 (specification->package "i3status")
			 (specification->package "dmenu")
			 (specification->package "st")
			 (specification->package "gvfs")
			 (specification->package "nss-certs"))
		   %base-packages))

 ;; Below is the list of system services.  To search for available
 ;; services, run 'guix system search KEYWORD' in a terminal.
 (services
  (append (list (service bluetooth-service-type)
		(service cups-service-type
			 (cups-configuration
			  (web-interface? #t)))
		(service docker-service-type)
		(service gnome-keyring-service-type)
		(service syncthing-service-type (syncthing-configuration (user "flake")))
		(set-xorg-configuration (xorg-configuration (keyboard-layout keyboard-layout)))
		(udev-rules-service 'logitech-unify %logitech-unify-udev-rules)
	  ;; This is the default list of services we
	  ;; are appending to.
	  (modify-services
	   %desktop-services
	   
	   (elogind-service-type
	    config =>
	    (elogind-configuration
	     (inherit config)
	     (handle-lid-switch-docked 'suspend))))))

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
		      %base-file-systems)))
