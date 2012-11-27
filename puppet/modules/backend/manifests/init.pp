class backend {
  file { '/usr/local/sbin/register-backend':
    content => template('backend/register-backend'),
    mode    => 0755,
  }

  exec { 'register backend':
    require => File['/usr/local/sbin/register-backend'],
    command => '/usr/local/sbin/register-backend',
  }
}

