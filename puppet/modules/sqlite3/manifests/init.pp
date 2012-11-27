class sqlite3 {
  $packages = [
    'sqlite3',
  ]

  package { $packages:
    ensure => installed,
  }
}

