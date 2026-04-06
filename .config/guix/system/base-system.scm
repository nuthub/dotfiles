;; This is my operating system configuration
(use-modules (gnu)
	     (guix)
	     (gnu packages admin)
	     (gnu packages file-systems)
	     (gnu packages firmware)
	     (gnu packages fonts)
	     (gnu packages freedesktop)
	     (gnu packages gnome)
	     (gnu packages linux)
	     (gnu packages networking)
	     (gnu packages package-management)
	     (gnu packages rust-apps)
	     (gnu packages shells)
	     (gnu packages wm)
	     (gnu services authentication)
	     (gnu services containers)
	     (gnu services cups)
	     (gnu services dbus)
	     (gnu services desktop)
	     (gnu services linux)
	     (gnu services mcron)
	     (gnu services networking)
	     (gnu services pm)
	     (gnu services samba)
	     (gnu services ssh)
	     (gnu services virtualization)
	     (gnu services xorg)
	     (gnu system accounts)
	     (gnu system locale)
	     (gnu system privilege)
	     (gnu system setuid)
	     (nongnu packages firmware)
	     (nongnu packages fonts)
	     (nongnu packages linux)
	     (nongnu packages mozilla)
	     (nongnu system linux-initrd))

;; extend the list of base file systems
(define %my-base-fs
  (cons*
   (file-system
    (mount-point "/home/flake/dav/olat.vcrp.de")
    (device "https://olat.vcrp.de/webdav")
    (type "davfs")
    (mount? #f)
    (options "noauto,user"))
   (file-system
    (mount-point "/home/flake/dav/cloud.nuthouse.de")
    (device "https://cloud.nuthouse.de/remote.php/dav/files/nutcase")
    (type "davfs")
    (mount? #f)
    (options "noauto,user"))
   %base-file-systems))

;; define a base operating system that can be inherited
(define %my-base-os
  (operating-system
   (host-name #f) ; is set in an inheritance
   (file-systems #f) ; is set in an inheritance
   (kernel linux)
   (kernel-loadable-modules (list v4l2loopback-linux-module)) 
   (initrd microcode-initrd)
   (locale "en_US.utf8")
   (locale-definitions (cons (locale-definition
			      (name "de_DE.utf8") (source "de_DE"))
			     %default-locale-definitions))
   (timezone "Europe/Berlin")
   (keyboard-layout (keyboard-layout "de" #:options '("ctrl:nocaps")))
   (name-service-switch %mdns-host-lookup-nss)
   (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(targets (list "/boot/efi"))
		(keyboard-layout keyboard-layout)))
   ;; The list of user accounts ('root' is implicit).
   (users (cons* (user-account
		  (name "flake")
		  (comment "Julian Flake")
		  (group "users")
		  (home-directory "/home/flake")
		  (shell (file-append zsh "/bin/zsh"))
		  (supplementary-groups '("users" "wheel" "netdev" "audio" "video" "tty"
					  "input" "disk" "kvm" "lp" "lpadmin"
					  "dialout" "libvirt"))) ;; lp is needed for bluetooth
		 %base-user-accounts))
   (setuid-programs
    (append (list (setuid-program
		   (program (file-append opendoas "/bin/doas")))
		  (setuid-program
		   (program (file-append libmbim "/bin/mbimcli")))
		  (setuid-program
		   (program (file-append davfs2 "/sbin/mount.davfs"))))
	    %setuid-programs))
   (privileged-programs
    (append (list (privileged-program
                   (program (file-append espanso-wayland "/bin/espanso"))
                   (capabilities "cap_dac_override+p")))
            %default-privileged-programs))
   (packages (append
	      (map
	       (compose list specification->package+output)
	       '(;; hardware related
		 "intel-vaapi-driver" "intel-media-driver-nonfree"
		 "libva-utils" "mesa"
		 ;; shell and shell tools
		 "bash"
		 "zsh"
		 ;;		 "zsh-autosuggestions"
		 ;;		 "zsh-syntax-highlighting"
		 ;;		 "zsh-completions"
		 ;;		 "zsh-autopair"
		 ;; basics to get data and backups on the system
		 "git"
		 "stow"
		 "opendoas" ; install it additionally to make man pages available
		 "gnupg"
		 "borg"
		 "curl"
		 "emacs-minimal"
		 "rsync"))
	      %base-packages))
   (services (append (list
		      (service openssh-service-type)
		      (service fprintd-service-type)
		      (service samba-service-type (samba-configuration
						   (enable-smbd? #t)
						   (config-file (plain-file "smb.conf" "\
[global]
map to guest = Bad User
logging = syslog@1

[public]
browsable = yes
path = /home/flake/Public
read only = yes
guest ok = yes
guest only = yes\n"))))
		      (simple-service 'doas-config-file etc-service-type
				      (list `("doas.conf"
					      ,(plain-file
						"doas.conf" "permit persist :wheel\n"))))
		      (simple-service 'davfs-config-file etc-service-type
				      (list `("davfs2/davfs2.conf"
					      ,(plain-file
						"davfs.conf" "dav_group users\nbuf_size 65\n"))))
		      (simple-service 'v4l2loopback-options-file etc-service-type
				      (list `("modprobe.d/v4l2loopback.conf"
					      ,(plain-file
						"v4l2loopback.conf"
						"options v4l2loopback devices=1 exclusive_caps=1 card_label=\"v4l2loopback\""))))
		      (simple-service 'fcc-unlock-link etc-service-type  ; has no effect
				      `(("ModemManager/fcc-unlock.d/1eac:100d"
					 ,(file-append modem-manager "/share/ModemManager/fcc-unlock.available.d/1eac"))))
		      (service rootless-podman-service-type
			       (rootless-podman-configuration
				(subgids
				 (list (subid-range (name "flake"))))
				(subuids
				 (list (subid-range (name "flake"))))))
		      (service iptables-service-type
			       (iptables-configuration))
		      (service kernel-module-loader-service-type '("v4l2loopback"))
		      (service bluetooth-service-type)
		      (service cups-service-type
			       (cups-configuration
				(web-interface? #t)
				(default-shared? #f)
				(default-paper-size "A4")))
		      (service power-profiles-daemon-service-type)
		      (service gnome-keyring-service-type)
		      (service screen-locker-service-type
			       (screen-locker-configuration
				(name "swaylock")
				(program (file-append swaylock "/bin/swaylock"))
				(allow-empty-password? #f)
				(using-pam? #t)
				(using-setuid? #f)))
		      (service libvirt-service-type
			       (libvirt-configuration
				(unix-sock-group  "libvirt")))
		      (service virtlog-service-type)
		      ;;(service geoclue-service-type)
		      (udev-rules-service 'solaar-udev-rules solaar)
		      (simple-service 'dbus-extras
				      dbus-root-service-type (list blueman))
		      (simple-service 'fwupd-dbus dbus-root-service-type
				      (list fwupd-nonfree))
		      (simple-service 'fwupd-polkit polkit-service-type
				      (list fwupd-nonfree))
		      (simple-service 'guix-moe guix-service-type
				      (guix-extension
				       (authorized-keys
					(list (plain-file "guix-moe-old.pub"
							  "(public-key (ecc (curve Ed25519) (q #374EC58F5F2EC0412431723AF2D527AD626B049D657B5633AAAEBC694F3E33F9#)))")
					      ;; New key since 2025-10-29.
					      (plain-file "guix-moe.pub"
							  "(public-key (ecc (curve Ed25519) (q #552F670D5005D7EB6ACF05284A1066E52156B51D75DE3EBD3030CD046675D543#)))")))
				       (substitute-urls
					'("https://cache-cdn.guix.moe")))))
		     ;; This is the (modified) default list of services we are appending to.
		     (modify-services %desktop-services
				      (delete gdm-service-type)
				      (elogind-service-type
				       config => (elogind-configuration
						  (inherit config)
						  (handle-power-key 'suspend)
						  (handle-lid-switch-docked 'ignore)))
				      (guix-service-type
				       config => (guix-configuration
						  (inherit config)
						  (substitute-urls (append
								    (list "https://substitutes.nonguix.org")
								    %default-substitute-urls))
						  (authorized-keys (append
								    (list (local-file "./nonguix-signing-key.pub"))
								    %default-authorized-guix-keys)))))))))
