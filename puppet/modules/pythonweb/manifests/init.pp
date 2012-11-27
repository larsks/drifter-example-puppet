class pythonweb {
  $packages = [
    'python-sqlalchemy',
    'python-yaml',
    'python-virtualenv',
  ]

  package { $packages:
    ensure => installed,
  }
}

