class webserver {
  include apache

  $packages = [
    'apache2',
  ]

  $modules = [
    'rewrite.load',
    'proxy.conf',
    'proxy.load',
    'proxy_http.load',
  ]

  package { $packages:
    ensure => installed,
  }

  service { 'apache2':
    ensure => running,
    enable => true,
  }

  apache::module { $modules: }
}

