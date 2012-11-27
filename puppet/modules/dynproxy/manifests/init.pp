class dynproxy {
  include git
  
  git::repository { '/var/lib/dynproxy':
    url => 'git://github.com/larsks/dynproxy-http.git',
    notify => Service['apache2']
  }

  file { '/etc/dynproxy.yml':
    source => 'puppet:///modules/dynproxy/dynproxy.yml',
    notify => Service['apache2']
  }

  file { '/usr/local/sbin/dynproxy-rwm':
    source => 'puppet:///modules/dynproxy/dynproxy-rwm',
    mode   => 0755,
    notify => Service['apache2']
  }
}

