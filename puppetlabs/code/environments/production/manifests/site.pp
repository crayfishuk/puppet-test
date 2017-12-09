# This is the default manifest
# for the 'production' environment

node 'puppet1.prolateral.local' {
  include cfisher

  include dovecot

  class { 'mysql::server':
    root_password           => 'strongpassword',
    remove_default_accounts => true,
  }

  exec { 'apt-get update':
    command => "/usr/bin/apt-get update",
    onlyif => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))'"
  }
}

