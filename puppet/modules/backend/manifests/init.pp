class backend {
  include webserver

  file { '/usr/local/sbin/register-backend':
    content => template('backend/register-backend'),
    mode    => 0755,
  }

  # Update master once/minute.
  cron { 'register backend':
    require => Service['avahi-daemon'],
    command => '/usr/local/sbin/register-backend',
  }

  file { '/var/www/whoami.html':
    content => template('backend/whoami.html'),
    mode    => 0644,
  }
}

