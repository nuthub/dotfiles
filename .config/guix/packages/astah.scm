;;; Copyright © 2023,2024 Julian Flake <flake@uni-koblenz.de

(define-module (astah)
  #:use-module (nutguix packages astah)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (nonguix build-system binary)
  #:use-module (guix build-system copy)
  #:use-module ((nonguix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gcc))

;; Simply setting the license file via Astah's GUI doesn't work, because $GUIX_PROFILE/lib/astah_professional directory (aka astah install directory) is not writable.
;; Therefore, the license file needs to be packaged, in order to be able to place it in the $GUIX_PROFILE/lib/astah_professional
;; During build time, the license file needs to be found at file:/tmp/astah_professional_license.xml (it must not ne shared with the public)
;;
;; There is a more elegant way: see help-guix@gnu.org, 2024-11-13 09:34, Parnikkapore, Re: Add external data to a package
;; just define an origin (e.g. (define astah-license (origin...)) and use it as (data #astah-license) in the let expression of the 'add-license phase in the astah-professional-licensed package
;;
;; Another way is described here: https://www.reddit.com/r/GUIX/comments/1h2zl4a/question_how_do_i_build_a_text_file_and_refer_to/
(define-public astah-professional-license
  (package
   (name "astah-professional-license")
   (version "2024-11")
   (source
    (local-file "../files/astah_professional_license.xml"))
   (build-system copy-build-system)
   (arguments
    (list
     #:install-plan #~'(("astah_professional_license.xml" "lib/astah_professional/astah_professional_license.xml"))))
   (synopsis "Astah Professional faculty license")
   (description "valid one year?")
   (home-page "http://astah.net/products/astah-professional")
   (license #f)))

;; It's not sufficient to just install the license into $GUIX_PROFILE/lib/astah_professional. Astah does not recognize the file, probably because it links to another directory in the store.
;; Therefore, I create a new package that takes the license file as build input and copies the license file in the resulting package, which effectively is astah-professional + astah-professional-license
(define-public astah-professional-licensed
(package
(inherit astah-professional)
(name "astah-professional-licensed")
(version "10.1.0.9ceee1")
(inputs `(("gcc:lib" ,gcc "lib")
	  ("astah-professional-license" ,astah-professional-license)))
(arguments
 `(#:patchelf-plan
   '(("usr/lib/astah_professional/lib/rlm/librlm1601.so" ("gcc:lib"))
     ("usr/lib/astah_professional/lib/rlm/x64/librlm1601.so" ("gcc:lib")))
   #:install-plan
   '(("usr/lib/" "lib")
     ("usr/bin/" "bin")
     ("usr/share/" "share"))
   #:phases (modify-phases
	     %standard-phases
	     (add-after 'install 'add-license
			(lambda* (#:key inputs #:allow-other-keys)
			  (let* ((lic-file "astah_professional_license.xml")
				 (lib-dir "/lib/astah_professional/"))
			    (copy-file
			     (string-append (assoc-ref inputs "astah-professional-license") lib-dir lic-file)
			     (string-append (assoc-ref %outputs "out") lib-dir lic-file)))
			  #t)))))
(synopsis "Astah Professional (with license file), an Easy-to-use UML2.x modeler")))
