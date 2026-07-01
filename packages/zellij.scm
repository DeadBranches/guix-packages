(define-module (packages zellij)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (zellij-bin))

(define zellij-bin
  (package
    (name "zellij")
    (version "0.44.1")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
              "https://github.com/zellij-org/zellij/releases/download/"
            "v" version "/zellij-x86_64-unknown-linux-musl.tar.gz"))
        (sha256
          (base32 "0j9bmzl50lm1h5ss07qr8lhpd41akly2d24qjdfwm7sj3l12b636"))))
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
        '(("zellij" "bin/zellij"))
      #:strip-binaries? #f
      #:validate-runpath? #f
      #:phases (modify-phases %standard-phases
                (delete 'patch-shebangs))))
    (synopsis "Zellij")
    (description "A terminal workspace with batteries included")
    (home-page "https://www.zellij.dev")
    (license license:expat)))
