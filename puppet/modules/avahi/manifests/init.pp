class avahi {
  $packages = [
    'avahi-daemon',
    'avahi-utils',
  ]

  package { $packages:
    ensure => installed,
  }

  service { 'avahi-daemon':
    ensure => running,
    enable => true,
  }
}

