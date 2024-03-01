(append
 (list
  (channel
   (name 'nonguix)
   (url "https://gitlab.com/nonguix/nonguix")
   ;; Enable signature verification:
   (introduction
    (make-channel-introduction
     "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
     (openpgp-fingerprint
      "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
  (channel
   (name 'nutguix)
   (url "https://github.com/nuthub/nutguix")
   ;; to test local changes, either commit (without push) and make a `guix pull' with the following location
   ;; or better: do a `guix install <package> -L ~/git/nutguix'
   ;;(url (string-append "file://" (getenv "HOME") "/git/nutguix"))
   (branch "main")
   (introduction
    (make-channel-introduction
     "1fe9a666b2e6c3398a5057f861986d3183bdab2a"
     (openpgp-fingerprint
      "99A2 CE39 CD81 BD0A 0423  3B9D A998 EA3B DF45 39EF")))))
 %default-channels)
