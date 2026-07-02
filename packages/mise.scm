(define-module (mise)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (mise))

(define-public mise
  (package
    (name "mise")

    (version "v2026.4.19")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
              "https://github.com/jdx/mise/releases/download/" version "/mise-" version "-linux-x64.tar.gz"))
        (sha256
	  (base32 "1js4zjx3cqqx0jnnf2qyvw8dk7jayq00masnkc57jpnxjiy07gqp"))))
;#	  (base32 "1js4zjx3cqqx0jnnf2qyvw8dk7jayq00masnkc57jpnxjiy07gqp"))))
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
        '(("bin/mise" "bin/mise"))
      #:strip-binaries? #f
      #:validate-runpath? #f
      #:phases (modify-phases %standard-phases
                (delete 'patch-shebangs))))
    (synopsis "mise")
    (description "Your de env, already prepped")
    (home-page "https://mise.en.ev")
    (license license:expat)))
