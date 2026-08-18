;; Apply manifest to ./guix-profile:
;; 
;; guix package -L ~/.config/guix/packages -L ~/git/nutguix -m ~/.config/guix/user/manifest.scm
;;
(specifications->manifest
 '(
   ;; I did not manage to install this into the home profile
   "astah-professional-licensed"
   ;; qemu does not find these, if installed in system profile
   "ovmf-x86-64"

   ;; texlive
   "emacs-org-texlive-collection"
   ;; texlive collections
   ;; also input of emacs-org-texlive-collection
   "texlive-collection-latexrecommended"
   ;; to check
   "texlive-collection-basic" 
   "texlive-collection-binextra"
   ;; "texlive-collection-context"
   "texlive-collection-fontsrecommended"
   "texlive-collection-fontutils"
   "texlive-collection-langenglish"
   "texlive-collection-langgerman"
   "texlive-collection-latex"
   ;; additional
   "texlive-collection-luatex"
   "texlive-collection-mathscience"
   "texlive-collection-metapost"
   "texlive-collection-pictures"
   "texlive-collection-plaingeneric"
   ;; "texlive-collection-xetex"
   
   ;; engrave-faces needs these
   "texlive-fvextra"
   "texlive-upquote"
   "texlive-tcolorbox"
   "texlive-float"
   "texlive-pdfcol"

   ;; additional texlive packages
   "texlive-biber"

   ;; beamerthemekoblenz needs opensans
   "texlive-opensans" 

   ;; beamerthemenuthouse needs these
   "texlive-fontawesome" "texlive-fira"

   ;;CEUR template needs apacite
   "texlive-apacite"

   ;; my org-latex-examples need these
   "texlive-blindtext"
   "texlive-acronym"
   "texlive-bigfoot"
   "texlive-biblatex"

   ;; PDFPC packages
   ;; for adding speaker-notes
   "texlive-pdfpc"
   ;; for embedding videos in presentations
   "texlive-pdfpc-movie"
   ))
