# cd /vagrant/puppet/manifests/
# puppet apply -v ubuntu-lamp.pp --modulepath=/vagrant/puppet/modules/ --noop
# puppet apply -v ubuntu-lamp.pp --modulepath=/vagrant/puppet/modules/

# puppet examples

node puppet1.prolateral.test {
  include motd
  include openssh


  exec { 'apt-get update':
    path => '/usr/bin',
  }

  package { 'vim':
    ensure => present,
  }

  class { 'mysql::server':
    root_password           => 'strongpassword',
    remove_default_accounts => true,
  }
}