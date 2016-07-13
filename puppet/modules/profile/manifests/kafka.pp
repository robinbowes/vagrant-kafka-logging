# install kafka
class profile::kafka {

  class { 'kafka':
    version       => '0.10.0.0',
    scala_version => '2.11',
    install_java  => true,
  }
  class { 'kafka::broker':
    config => {
      'broker.id'                     => '0',
      'zookeeper.connect'             => 'zookeeper.int.yo61.net:2181',
      'inter.broker.protocol.version' => '0.10.0.0',
    },
  }

}