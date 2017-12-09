#  This is the default .pp file for the 'user' module


class cfisher {

  group { 'admin':
    ensure => present,
  }

  accounts::user { 'cfisher':
    ensure  => present,
    require => Group['admin'],
    groups  => [
      'admin',
      'sudo',
    ],
    comment => 'Test ssh keys',
    home    => '/home/cfisher',
    sshkeys  => [
      'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAojw/lK4PeR06XVQKkml4p/nJmvkK1J6rlaZ6fdi6uyfcwcWpukAob+4taOaU5uRbQO1Aojmz7al+bxO3jHdeDp90kePcIfthxtzq2zP6t2AnTbBw0TTdtMc0oNo4Ojv1P7XZoL8IImy/Ij2prBy6KP4dB4+a5DkqS/I7lWnYPa+ZXCuErlZMTex4+/gO/Tr4ZYx/1ATOZvipAWrjJkX6/JscVWScOks23UynMEIvDg7YcwWQgw327UvK9cJf6dljSngCAJY2YWVjZixt4tmLhbnolXDpvDoevz0eqmENUr5b2kOMIoIRiC2DeY3B2Zb/PfkdrivqQhts1ZXFhdPQljwuyYCn6gAze5n2gTMN1OXLWC3ESuExoolQ84ky0KAA9SS2Pk2Er3Re27U/JIQODArUnl6psxC1o/IDmsyQ9ZjXhwf3JN+Ql+hnrNBUv20nNopAwuvrqyn2Tb08Y3JBacPj5b25CrUX2jnBNdOb0wP+6lEhlEwHFUmvnnFSttc6HKWZjxN4O3Xr5gW0hl0HNZ1kUjPosBr5W+kX6gSFAPGPWm6pW3xw0fLAFlxNsFY076rB3eMNOi2occY7jw4C7zxe+KeND7nUk78vNlCjCfbK1M2XQetz5n1lGmbh5hwco1vQAsFsPzeQgMpwwAz5UVESPELuUuvC1n3j+CHDmZE= mouse-ssh'
    ],
    managehome => true,  # This will create/remove homedir if set
  }


  #
  # accounts::user { 'bob':
  #   uid      => '4001',
  #   gid      => '4001',
  #   group    => 'staff',
  #   shell    => '/bin/bash',
  #   password => '!!',
  #   locked   => false,
  # }

}