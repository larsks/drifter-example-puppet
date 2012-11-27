class wsgiserver {
  include apache
  include webserver

  $packages = [
    'libapache2-mod-wsgi',
  ]

  $modules = [
    'wsgi.load',
    'wsgi.conf',
  ]

  package { $packages:
    ensure => installed,
  }

  apache::module { $modules: }
}

