;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
(use-service-modules cups desktop docker networking ssh syncthing xorg)

(operating-system
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
                (supplementary-groups '("wheel" "netdev" "audio" "video" "docker" "lpadmin")))
               %base-user-accounts))

 ;; Packages installed system-wide.  Users can also install packages
 ;; under their own account: use 'guix search KEYWORD' to search
 ;; for packages and 'guix install PACKAGE' to install a package.
 (packages (append (list (specification->package "i3-wm")
                         (specification->package "i3status")
                         (specification->package "dmenu")
                         (specification->package "st")
                         (specification->package "nss-certs"))
                   %base-packages))

 ;; Below is the list of system services.  To search for available ;; services, run 'guix system search KEYWORD' in a terminal.
 (services
  (append (list (set-xorg-configuration
		 (xorg-configuration (keyboard-layout keyboard-layout)))
		(service cups-service-type)
		(service docker-service-type)
		(service syncthing-service-type
			 (syncthing-configuration (user "flake"))))

          ;; This is the default list of services we
          ;; are appending to.
          %desktop-services))
 (bootloader (bootloader-configuration
              (bootloader grub-bootloader)
              (targets (list "/dev/sda"))
              (keyboard-layout keyboard-layout)))
 (swap-devices (list (swap-space
                      (target (uuid
                               "ad0cdc52-f971-4b51-ac1f-e5dfbfc1a3e9")))))

 ;; The list of file systems that get "mounted".  The unique
 ;; file system identifiers there ("UUIDs") can be obtained
 ;; by running 'blkid' in a terminal.
 (file-systems (cons* (file-system
                       (mount-point "/")
                       (device (uuid
                                "98d8fe42-db5a-40a3-8683-1de65680be86"
                                'ext4))
                       (type "ext4")) %base-file-systems)))
