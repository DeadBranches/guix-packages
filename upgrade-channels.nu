# Upgrade packages from guix repos to the newest versions.
#
# Usage: `nu guix-upgrade.nu`

def unpin-my-channels [] {
  $in 
  | (
    str replace --regex (
      [
      '(?<=DeadBranches.+?\n'
        '.+?)'                # End lookbehind
      '(\n\s+\(commit "[0-9a-f]+?"\))'  # End capture 1
      ] | str join )
    ''
  )
}

def main [] {
  use std/log

  const pinned_channels_file = 'channels-lock.scm'
  const package_manifest = 'manifest.scm'
  const unpinned_channels_file = 'my-channels.conf'

  let guix_config_dir = ($nu.home-dir | path join .config guix)
  let guix_user_repo = ($nu.home-dir | path join guix)

  if ((sys host).hostname != 'flurry') {
    log error "Only flurry is allowed to upgrade the guix base packages. It'll take you too long."
    error make --unspanned { 
      code: 'guix::upgrade::error' 
      msg: "Invalid host. Could not upgrade packages." 
      help: "Run the same command on flurry"
    } }

  print $"Updating guix base packages to those at the latest commits."
  guix pull $"--channels=($guix_user_repo | path join $unpinned_channels_file)"
  
  print $"Pinning guix repos to new commit hashes."
  guix describe --format=channels
    | unpin-my-channels
    | tee {
      log debug $"Backing up existing pinned channel file."
      ( cp 
          ($guix_user_repo | path join $pinned_channels_file) 
          $"($guix_user_repo | path join $pinned_channels_file)-" 
      ) }
    | save --force ($guix_user_repo | path join $pinned_channels_file) 

    print $"Make my profile match the manifest.scm--now with updated versions"
    guix package $"--manifest=($guix_user_repo | path join $package_manifest)"


}

# Run main when sourced
(main)
