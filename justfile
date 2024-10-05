# -*- mode: just; -*-

# Show recipes
default:
	just --choose

# Mount University's OpenOlat WebDav
nutcloud-mount:
	gio mount davs://cloud.nuthouse.de/remote.php/dav/files/nutcase

# Unmount University's OpenOlat WebDav
nutcloud-umount:
	gio mount -u davs://cloud.nuthouse.de/remote.php/dav/files/nutcase

# Mount University's OpenOlat WebDav
olat-mount:
	gio mount davs://olat.vcrp.de/webdav

# Unmount University's OpenOlat WebDav
olat-umount:
	gio mount -u davs://olat.vcrp.de/webdav

# Reconfigure the system
guix-reconfigure:
	doas guix system reconfigure ~/.config/guix/config.scm

# Pull latest Guix
guix-pull:
	guix pull

# Free Space by deleting old Guix generations
guix-clean:
	guix package --delete-generations=1m & \
	doas guix system delete-generations 1m && \
	guix gc && \
	exit 0

# Run a Borg Backup to StorageBox
backup-ssh:
	borg-backup.sh ssh

# Run a Bord Backup to external disk
backup-hdd:
	borg-backup.sh hdd

# Deploy dotfiles
stow-dotfiles:
	cd ~/.dotfiles && stow .

# FCC Unlock
fcc-unlock:
	mbimcli -p -d /dev/wwan0mbim0 --quectel-set-radio-state=on

# FCC Status
fcc-status:
	mbimcli -p -d /dev/wwan0mbim0 --quectel-query-radio-state
