def main [] {
  let guix_user_repo = ($nu.home-dir | path join guix)

  print "Exporting manifest from current profile..."
  guix package --export-manifest
  | save --force ($guix_user_repo | path join manifest.scm)

  print "Committing and pushing..."
  git -C $guix_user_repo add -A
  git -C $guix_user_repo commit -m "update manifest and packages"
  git -C $guix_user_repo push
}

(main)
