;;; Custom updater for the nushell binary-release package.
;;;
;;; guix refresh discovers updaters by scanning guix/import/ modules across
;;; the whole %load-path, so this file just needs to live at
;;; <dir>/guix/import/nushell-bin.scm and be used with `guix refresh -L <dir>`.
;;;
;;; The built-in github updater rejects nushell's release tarball because the
;;; filename has a target triple after the version; this updater knows the
;;; exact URL shape.  It finds the latest version by following the
;;; releases/latest redirect, so it needs no GitHub API token.

(define-module (guix import nushell-bin)
  #:use-module (guix upstream)
  #:use-module (guix packages)
  #:use-module (web client)
  #:use-module (web response)
  #:use-module (web uri)
  #:export (%nushell-bin-updater))

(define (nushell-latest-version)
  "Return the tag of the latest published nushell release, from the
releases/latest redirect."
  (let ((response
         (http-head
          (string->uri "https://github.com/nushell/nushell/releases/latest"))))
    (basename (uri-path (response-location response)))))

(define (nushell-tarball-url version)
  (string-append "https://github.com/nushell/nushell/releases/download/"
                 version "/nu-" version "-x86_64-unknown-linux-gnu.tar.gz"))

(define (latest-nushell-release package)
  "Return an <upstream-source> for the latest nushell binary release."
  (let ((version (nushell-latest-version)))
    (upstream-source
     (package (package-name package))
     (version version)
     (urls (list (nushell-tarball-url version))))))

(define %nushell-bin-updater
  (upstream-updater
   (name 'nushell-bin)
   (description "Updater for the nushell binary release tarball")
   (pred (lambda (package)
           (string=? (package-name package) "nushell")))
   ;; NOTE: on Guix 1.4.0 and earlier this field is called `latest';
   ;; on current Guix it is called `import'.  Rename if refresh errors
   ;; on an invalid field specifier.
   (import latest-nushell-release)))
