node default {
}

node 'master' inherits default {
  include frontend
}

node /^node-.*/ inherits default {
  include backend
}

