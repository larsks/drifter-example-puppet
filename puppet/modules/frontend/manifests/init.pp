class frontend {
  include webserver
  include wsgiserver
  include pythonweb
  include sqlite3
  include dynproxy

  file { '/etc/apache2/sites-enabled/000-default':
    ensure => absent,
    notify => Service['apache2'],
  }

  file { '/etc/apache2/sites-enabled/frontend':
    source => 'puppet:///modules/frontend/frontend',
    notify => Service['apache2'],
  }
}

