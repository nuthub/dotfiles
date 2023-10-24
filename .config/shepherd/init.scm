;; init.scm -- default shepherd configuration file.
;; from https://www.gnu.org/software/shepherd/manual/html_node/Managing-User-Services.html
(use-modules (shepherd service)
             ((ice-9 ftw) #:select (scandir)))

;; Send shepherd into the background
;; (perform-service-action 'shepherd 'daemonize)
;; (action 'shepherd 'daemonize)

;; Load all the files in the directory 'init.d' with a suffix '.scm'.
(for-each
 (lambda (file)
   (load (string-append "init.d/" file)))
 (scandir (string-append (dirname (current-filename)) "/init.d")
          (lambda (file)
            (string-suffix? ".scm" file))))


