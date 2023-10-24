;; emacs user service
(use-modules (shepherd support))

(define emacs
  (service
   '(emacs)
   #:documentation "Run `emacs' as daemon"
   #:start (make-forkexec-constructor
	    '("emacs" "--fg-daemon")
	    #:log-file (string-append %user-log-dir "/emacs.log"))
   #:stop (make-kill-destructor
	   #:grace-period 20)
   #:respawn? #f))

(register-services (list emacs))
(start-service emacs)
