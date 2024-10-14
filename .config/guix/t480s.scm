(define %my-host-name
  "nutbook8")
(define %my-firmware
  (list linux-firmware i915-firmware))
(define %my-file-systems
  (cons* (file-system (mount-point "/boot/efi")
		      (device (uuid "FCE6-96C0"
				    'fat32))
		      (type "vfat"))
	 (file-system (mount-point "/")
		      (device (uuid
			       "5c890181-055c-4db3-9a47-2e3769ec24ea"
			       'ext4))
		      (type "ext4"))
	 %base-file-systems))
(define %my-swap-devices
  (list (swap-space
	 (target (uuid
		  "5abe7967-fcb6-4888-8b05-a6413944c60b")))))
