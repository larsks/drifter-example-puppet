# A simple resource definition for git repositories.
class git {
  define repository (
    $url,
    $workdir=undef,
    $branch=undef,
    $recursive=undef,
    $pull=true
  ) {
    if $workdir {
      $r_workdir = $workdir
    } else {
      $r_workdir = $name
    }

    if $branch {
      $branch_arg = "-b $branch"
    }

    if $recursive {
      $recursive_arg = '--recursive'
    }

    exec { "clone-gitrepo-$name":
      creates => "$r_workdir",
      command => "/usr/bin/git clone $branch_arg $recursive_arg $url $r_workdir",
    }

    file { $r_workdir:
      ensure  => directory,
      require => Exec["clone-gitrepo-$name"],
    }

    if $pull {
      exec { "update-gitrepo-$name":
        require => Exec["clone-gitrepo-$name"],
        cwd     => "$r_workdir",
        command => '/usr/bin/git pull',
      }
    }
  }
}

