(define-module (atuin)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (atuin))

(define-public atuin
  (package
    (name "atuin")
    (version "18.15.1")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
              "https://github.com/atuinsh/atuin/releases/download/"
              "v" version "/atuin-x86_64-unknown-linux-gnu.tar.gz"))
        (sha256
          (base32 "0jicvdv9qzimsv9r36drqh6r9kxzi11sckl6mrjxh0v6g6xdlhzx"))))
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
        '(("atuin" "bin/atuin"))
      ; #:strip-binaries? #f
      #:validate-runpath? #f
      #:phases (modify-phases %standard-phases
                (delete 'patch-shebangs))))
    (synopsis "Atuin")
    (description "Making your shell magical")
    (home-page "https://atuin.sh")
    (license license:expat)))
