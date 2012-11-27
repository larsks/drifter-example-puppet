class pythonweb {
  $packages = [
    'python-sqlalchemy',
    'python-bottle',
    'python-yaml',
  ]

  package { $packages:
    ensure => installed,
  }
}

