(use-modules (gnu)
             (guix))

(include "base-system.scm")

(operating-system
 (inherit base-system)
 (host-name "nutbook8")
 (firmware (list linux-firmware i915-firmware intel-microcode))
 (file-systems (cons* (file-system (mount-point "/boot/efi")
				   (device (uuid "FCE6-96C0"
						 'fat32))
				   (type "vfat"))
		      (file-system (mount-point "/")
				   (device (uuid
					    "5c890181-055c-4db3-9a47-2e3769ec24ea"
					    'ext4))
				   (type "ext4"))
		      %base-file-systems))
 (swap-devices (list (swap-space
		      (target (uuid
			       "5abe7967-fcb6-4888-8b05-a6413944c60b"))))))
