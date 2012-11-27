class webserver {
  $packages = [
    'apache2',
    'libapache2-mod-wsgi',
  ]

  $modules = [
    'rewrite.load',
    'wsgi.load',
    'wsgi.conf',
    'proxy.conf',
    'proxy.load',
    'proxy_http.load',
  ]

  package { $packages:
    ensure => installed,
  }

  define apache_module {
    file { "/etc/apache2/mods-enabled/$name":
      ensure => 'link',
      target => "../mods-available/$name",
    }
  }

  apache_module { $modules: }
}

