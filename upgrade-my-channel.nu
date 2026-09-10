# Guix repo upgrade.
#
# Updates first.
#
# Usage: `nu guix-upgrade.nu`

def main [] {

  const channels_file = 'channels-lock.scm'
  const package_manifest = 'manifest.scm'

  let guix_config_dir = ($nu.home-dir | path join .config guix)
  let guix_user_repo = ($nu.home-dir | path join guix)

  # How to add to guix packages
  # 1. Optionally add a package file as `packages/package-name.scm`
  # 2. Update the source of truth.
  #      Edit `manifest.scm` and add `package-name`.
  # 3. Update the remote repo.
  #      Run `guix add .` `guix push` because `guix pull` fetches from there
  # 4. Upgrade the device
  #      Run `guix pull -C
  print $"Updating remote repo."
  git -C $guix_user_repo add $channels_file $package_manifest
  git -C $guix_user_repo commit -m "update manifest"
  git -C $guix_user_repo push

  print $"Installing new packages."
  guix pull $"--channels=($guix_user_repo | path join $channels_file)"
  guix package $"--manifest=($guix_user_repo | path join $package_manifest)"

}

# Run main when sourced
(main)
