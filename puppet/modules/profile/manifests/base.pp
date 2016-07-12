class profile::base {

  # disable ipv6
  sysctl::value {
    'net.ipv6.conf.all.disable_ipv6': value => 1;
    'net.ipv6.conf.default.disable_ipv6': value => 1;
  }

}