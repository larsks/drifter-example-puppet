node default {
  include webserver
}

node 'master' inherits default {
  include wsgiserver
  include sqlite3
  include pythonweb
  include dynproxy
}

