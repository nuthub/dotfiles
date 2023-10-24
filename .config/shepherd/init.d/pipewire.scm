;; pipewire service
(use-modules (shepherd support))

(define pipewire
  (service
   '(pipewire)
   #:documentation "Run `pipewire'"
   #:start (make-forkexec-constructor
	    '("pipewire")
	    #:log-file (string-append %user-log-dir "/pipewire.log"))
   #:stop (make-kill-destructor)
   #:respawn? #t))

(register-services (list pipewire))
(start-service pipewire)
