class dynproxy {
  include git

  $dynproxy_dir = '/var/lib/dynproxy'
  $dynproxy_db = '/var/cache/apache2/dynproxy.db'
  
  git::repository { $dynproxy_dir:
    url => 'git://github.com/larsks/dynproxy-http.git',
    notify => Service['apache2']
  }

  exec { 'create dynproxy virtualenv':
    cwd     => $dynproxy_dir,
    command => 'sh create-virtenv.sh',
    require => [
      Git::Repository[$dynproxy_dir],
      Package['python-virtualenv'],
    ],
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

  exec { 'init dynproxy db':
    command => "rm -f $dynproxy_db && python $dynproxy_dir/dynproxy/initdb.py",
    notify  => Service['apache2']
  }

  file { $dynproxy_db:
    owner   => 'www-data',
    group   => 'www-data',
    mode    => 0644,
    require => Exec['init dynproxy db'],
  }
}

