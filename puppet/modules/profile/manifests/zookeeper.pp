class profile::zookeeper {

  class { 'zookeeper':
      repo                 => 'cloudera',
      cdhver               => '5',
      packages             => ['zookeeper', 'zookeeper-server'],
      service_name         => 'zookeeper-server',
      initialize_datastore => true,
      servers              => ['zookeeper.int.yo61.net'],
      install_java         => true,
      java_package         => 'java-1.8.0-openjdk-headless',
  }

}