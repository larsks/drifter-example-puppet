node default {
  Exec {
    path    => [ '/bin', '/usr/bin', '/usr/local/bin' ],
  }

  include avahi
}

node 'master' inherits default {
  include frontend
}

node /^node-.*/ inherits default {
  include backend
}

