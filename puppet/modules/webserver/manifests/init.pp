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

  apache::module { $modules: }
}

