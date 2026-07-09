# Guix repo updater.
#
# `source update-guix-repo.nu`

def main [] {

  let guix_config_dir = ($nu.home-dir | path join .config guix)
  let guix_user_repo = ($nu.home-dir | path join guix)

  print $"Updating guix user repo."
  guix pull $"--channels=($guix_user_repo | path join my-channels.conf)"

  print $"Updating guix repository and pinning"
  guix describe --format=channels 
  | save --force ($guix_config_dir | path join channels.scm)

  guix package --export-manifest                                      
  | save --force ($guix_user_repo | path join manifest.scm)            

  git -C $guix_user_repo add manifest.scm                               
  git -C $guix_user_repo commit -m "update manifest"                     
  git -C $guix_user_repo push                                             

}

# Run main when sourced
(main)

