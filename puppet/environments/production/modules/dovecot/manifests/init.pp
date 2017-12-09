# the package, file, service pattern

class dovecot {

  package { 'dovecot-common':
    ensure  => present,
    require => Exec['apt-get update'],
  }

  package { 'dovecot-mysql':
    ensure  => present,
    require => Exec['apt-get update'],
  }

  file { '/etc/dovecot/dovecot.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    source => "puppet:///modules/dovecot/dovecot.conf",
  }

  file { '/etc/dovecot/dovecot-sql.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => epp('dovecot/dovecot-sql.conf.epp', {
      'sqlhost'   => 'localhost',
      'sqldbname' => 'mydb',
      'sqluser'   => 'myuser',
      'sqlpass'   => 'mypass',
    })
  }

  service { 'dovecot':
    ensure    => running,
    enable    => true,
    subscribe => [
      File['/etc/dovecot/dovecot.conf'],
      File['/etc/dovecot/dovecot-sql.conf'],
    ]
  }

}