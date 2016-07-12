case $hostname {
  'node01': { include role::puppet }
  'node02': { include role::zookeeper }
  'node03': { include role::kafka }
  'node04': { include role::elastic }
  'node05': { include role::logstash }
  default: { fail "Unknown node '${hostname}'"}
}