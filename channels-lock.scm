(list (channel
       (name 'nonguix)
       (url "https://gitlab.com/nonguix/nonguix")
       (branch "master")
       (commit "4bc86c61d5ab661614b099bfe524f7f5798988b3"))
      (channel
       (name 'bin-guix)
       (url "https://github.com/ieugen/bin-guix")
       (branch "main")
       (commit "b38473115ee8f74fbb615e78063ddcbf11601e91"))
      (channel
       (name 'kat-packages)
       (url "https://github.com/DeadBranches/guix-packages.git")
       (branch "main"))
      (channel
       (name 'guix)
       (url "https://git.guix.gnu.org/guix.git")
       (branch "master")
       (commit "2ef8ed9f0df53bddf14bdecc2ea48c2d233213cc")
       (introduction
        (make-channel-introduction
         "9edb3f66fd807b096b48283debdcddccfea34bad"
         (openpgp-fingerprint
          "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
