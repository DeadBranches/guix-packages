(define-module (packages tailscale)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix utils)            ; %current-system / %current-target-system
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (tailscale))

(define %tailscale-version "1.102.3")

;; Tailscale ships one static tarball per CPU arch at
;;   https://pkgs.tailscale.com/stable/tailscale_<version>_<arch>.tgz
;; amd64 (flurry) hash below is from `guix download`. To bump versions later:
;;   1. change %tailscale-version
;;   2. guix download https://pkgs.tailscale.com/stable/tailscale_<new>_amd64.tgz
;;   3. paste the printed base32 into the amd64 slot
;; The arm64/arm/386 slots are placeholders for other machines (e.g. breeze);
;; fill them the same way only when you build for that arch.
(define (tailscale-arch system)
  (cond ((string-prefix? "x86_64"  system) "amd64")
        ((string-prefix? "aarch64" system) "arm64")
        ((string-prefix? "armhf"   system) "arm")
        ((string-prefix? "i686"    system) "386")
        (else (error "tailscale: unsupported system" system))))

(define (tailscale-hash arch)
  (cond ((string=? arch "amd64") "1xfy3is6989z33v6kadqn7xknr0kz8y34xngj0lzqzz53fsxkp9n")
        ((string=? arch "arm64") "0000000000000000000000000000000000000000000000000000")
        ((string=? arch "arm")   "0000000000000000000000000000000000000000000000000000")
        ((string=? arch "386")   "0000000000000000000000000000000000000000000000000000")
        (else (error "tailscale: no hash recorded for arch" arch))))

(define (tailscale-source system)
  (let ((arch (tailscale-arch system)))
    (origin
      (method url-fetch)
      (uri (string-append "https://pkgs.tailscale.com/stable/tailscale_"
                          %tailscale-version "_" arch ".tgz"))
      (sha256 (base32 (tailscale-hash arch))))))

(define-public tailscale
  (package
    (name "tailscale")
    (version %tailscale-version)
    (source (tailscale-source
              (or (%current-target-system) (%current-system))))
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
        '(("tailscale"  "bin/tailscale")
          ("tailscaled" "bin/tailscaled"))
        #:strip-binaries? #f
        #:validate-runpath? #f
        #:phases (modify-phases %standard-phases
                  (delete 'patch-shebangs))))
    (synopsis "Tailscale client and daemon (official static binaries)")
    (description "Statically-linked @command{tailscale} CLI and
@command{tailscaled} daemon, taken directly from Tailscale's prebuilt binary
release rather than built from source.  Running the daemon still needs a
service manager: a systemd unit on a foreign distro (Debian), or a Shepherd
service on Guix System, pointed at the binary in this profile.")
    (home-page "https://tailscale.com")
    (license license:bsd-3)))

tailscale
