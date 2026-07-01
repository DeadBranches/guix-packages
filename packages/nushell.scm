(define-module (packages nushell)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (nushell-bin))

(define nushell-bin
  (package
    (name "nushell")
    (version "0.112.2")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
              "https://github.com/nushell/nushell/releases/download/"
              version "/nu-" version "-x86_64-unknown-linux-gnu.tar.gz"))
        (sha256
          (base32 "15c368if9wsxfpqh10mya94d1sdpvaw1b9ia790z4616vmqw2f20"))))
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
        '(("nu" "bin/nu")
        ("nu_plugin_custom_values" "bin/nu_plugin_custom_values")
        ("nu_plugin_example" "bin/nu_plugin_example")
        ("nu_plugin_formats" "bin/nu_plugin_formats")
        ("nu_plugin_gstat" "bin/nu_plugin_gstat")
        ("nu_plugin_inc" "bin/nu_plugin_inc")
        ("nu_plugin_polars" "bin/nu_plugin_polars")
        ("nu_plugin_query" "bin/nu_plugin_query")
        ("nu_plugin_stress_internals" "bin/nu_plugin_stress_internals"))
      #:strip-binaries? #f
      #:validate-runpath? #f
      #:phases (modify-phases %standard-phases
                (delete 'patch-shebangs))))
    (synopsis "Nushell")
    (description "A new type of shell.")
    (home-page "https://www.nushell.sh")
    (license license:expat)))
