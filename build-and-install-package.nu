def list-packages [] {
  ls ($nu.home-dir | path join guix packages)
  | (get name | path parse).stem
  | input list --display name "What package? "
}

def flow [package: string] {
  [
    { 
    	label: 'Build the package' 
    	program: guix 
	arguments: ([ build -L ($nu.home-dir | path join guix packages) $package ])
    }
    { 
    	label: 'Install package into profile' 
	program: guix 
	arguments: ([ package -L ($nu.home-dir | path join guix packages) -i $package ])
    }
    {
    	label: 'Push to github'
	program: git
	arguments: ([ push origin main ])
    }
  ]
}

def main [] {

  (flow (list-packages))
  | each {|step|
    print $step.label
    if ([Y n]|(input list "Continue? ")) == Y or ($step.required?) { 
      (try { run-external $step.program ...$step.arguments}
       catch { error make { msg: "no idea what the problem is" } })
    }
  }
}

