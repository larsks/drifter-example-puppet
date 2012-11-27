class dynproxy {
  include git
  
  git::repository { '/var/lib/dynproxy':
    url => 'git://github.com/larsks/dynproxy-http.git',
  }

  file { '/etc/dynproxy.yml':
    content => 'dburi: sqlite:////var/cache/apache2/dynproxy.db',
  }
}

