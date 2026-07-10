(define-module (delta)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (delta-bin))

(define delta-bin
  (package
    (name "delta")
    (version "0.19.2")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
              "https://github.com/dandavidson/delta/releases/download/"
            "v" version "/delta-0.19.2-x86_64-unknown-linux-gnu.tar.gz"))
        (sha256
          (base32 "1claq6hp7qzbra8n39fjzs5j3v92ljsf06xhqgb5733ab1gmqscf"))))
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
        '(("delta" "bin/delta"))
      #:strip-binaries? #f
      #:validate-runpath? #f
      #:phases (modify-phases %standard-phases
                (delete 'patch-shebangs)
		;(delete 'install-license-files)
		)
      ))
    (synopsis "delta")
    (description "A syntax-highlighting pager for git, diff, grep, rg --json, and blame output")
    (home-page "https://dandavison.github.io/delta/")
    (license license:expat)))
