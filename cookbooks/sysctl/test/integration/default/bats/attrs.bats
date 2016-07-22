#!/usr/bin/env bats

# /proc/sys/net/ipv4/tcp_fin_timeout 29
@test "set a param via attributes (net.ipv4.tcp_fin_timeout)" {
  run cat /proc/sys/net/ipv4/tcp_fin_timeout
  [ "$output" -eq 29 ]
}
#     /proc/sys/vm/swappiness 19
@test "set a 2nd param via attributes (vm.swappiness)" {
  run cat /proc/sys/vm/swappiness
  [ "$output" -eq 19 ]
}
