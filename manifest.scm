;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(specifications->manifest
  (list "fd"
        "neovim"
        "rsync"
        "tree"
        "ripgrep"
        "jq"
        "python-huggingface-hub"
        "smartmontools"
        "git"
        "expect"
        "tldr"
        "tcpdump"
        "screen"
        "ffmpeg"
        "pciutils"
        "mpd"
        "zoxide"
        "ccache"
        "binwalk"
        "git-lfs"
        "parted"
        "gptfdisk"
        "mise"
        "atuin"
        "xxhash"
        "github-cli"
        "starship"
        "du-dust"
        "bottom"
        "bat"
        "nushell"
        "nss-certs"
        "glibc-locales"))
