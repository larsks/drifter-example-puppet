class apache {
  define module ($ensure='active') {
    file { "/etc/apache2/mods-enabled/$name":
      ensure     => $ensure ? {
        'absent' => 'absent',
        default  => 'link',
      },
      target => "../mods-available/$name",
    }
  }
}

