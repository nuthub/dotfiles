(define %my-host-name
  "nutbook9")
(define %my-firmware
  (list linux-firmware i915-firmware sof-firmware))
(define %my-file-systems
  (cons* (file-system (mount-point "/boot/efi")
		      (device (uuid "5ABD-915C"
				    'fat32))
		      (type "vfat"))
	 (file-system (mount-point "/")
		      (device (uuid
			       "adc17c36-52ab-4152-bcec-d22ef2ef0b9a"
			       'ext4))
		      (type "ext4"))
	 %base-file-systems))
(define %my-swap-devices
  (list (swap-space
	  (target (uuid
		   "5d6e3f43-681e-441d-8a79-bd57d6a6c4f1")))))
