(use-modules (gnu)
             (guix))

(include "base-system.scm")

(operating-system
 (inherit base-system)
 (host-name "nutbook9")
 (firmware (list linux-firmware i915-firmware sof-firmware))
 (file-systems (cons* (file-system (mount-point "/boot/efi")
				   (device (uuid "5ABD-915C"
						 'fat32))
				   (type "vfat"))
		      (file-system (mount-point "/")
				   (device (uuid
					    "adc17c36-52ab-4152-bcec-d22ef2ef0b9a"
					    'ext4))
				   (type "ext4"))
		      %base-file-systems))
 (swap-devices (list (swap-space
		      (target (uuid
			       "5d6e3f43-681e-441d-8a79-bd57d6a6c4f1"))))))
