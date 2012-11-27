class pythonweb {
  $packages = [
    'python-sqlalchemy',
    'python-bottle',
    'python-yaml',
    'python-virtualenv',
  ]

  package { $packages:
    ensure => installed,
  }
}

