# the package, file, service pattern

class dovecot {

  package { 'dovecot-common':
    require => [
      Package['postfix'],
      Package['mysql-server'],
    ],
    ensure  => latest,
  }

  package { 'dovecot-mysql':
    ensure => latest,
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