class frontend {
  include webserver
  include wsgiserver
  include pythonweb
  include sqlite3
  include dynproxy

  file { '/etc/apache2/sites-enabled/000-default':
    ensure  => absent,
    notify  => Service['apache2'],
    require => Package['apache2'],
  }

  file { '/etc/apache2/sites-enabled/frontend':
    source => 'puppet:///modules/frontend/frontend',
    notify => Service['apache2'],
    require => Package['apache2'],
  }

  file { '/etc/avahi/services/master.service':
    content => template('frontend/master.service'),
    require => Package['avahi-daemon'],
    notify  => Service['avahi-daemon'],
  }
}

