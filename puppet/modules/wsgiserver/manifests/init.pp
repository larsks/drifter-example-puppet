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
    notify => Service['apache2']
  }

  apache::module { $modules: }
}

