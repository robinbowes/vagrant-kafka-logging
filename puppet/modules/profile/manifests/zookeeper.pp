class profile::zookeeper {

  class { 'zookeeper':
      servers => ['zookeeper.int.yo61.net']
  }

}