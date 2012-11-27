node default {
  include webserver
}

node 'master' inherits default {
  include frontend
}

