class zeromq-pubsub {
  include zeromq

  cpanm::module {
    ['ZeroMQ::PubSub']:
      require => Package['libzmq-dev'];
  }

  user {
    "pubsub":
      shell => "/bin/bash",
      uid => 2501,
      managehome => true;
  }

  # cpanm module "ZeroMQ" uses zmq v1
  package {
    ['libzmq-dev']:
      ensure => installed;
  }

  file {
    "/home/pubsub/pubsub.pl":
      mode => 0750,
      owner => 'pubsub',
      content => template('zeromq-pubsub/pubsub.pl.erb'),
      require => User['pubsub'];
  
    "/etc/init.d/zeromq-pubsub":
      mode => 0755,
      owner => 'pubsub',
      content => template('zeromq-pubsub/init.erb'),
      require => User['pubsub'];
  }
}
