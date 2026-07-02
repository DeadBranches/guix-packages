#!/usr/bin/env nu

# Bootstrap guix on a new machine.
# Usage: nu bootstrap-guix.nu <manifest-file>

def main [manifest: path = 'manifest.scm'] {
  let guix_user_repo = ($nu.home-dir | path join guix)

  print "Pulling channels..."
  guix pull $"--channels=($guix_user_repo | path join my-channels.conf)"

  print $"Applying manifest from ($manifest)..."
  guix package -m $manifest

  print "Done."
}

# Allow the user to source the file and have it run

(main)
