#!/usr/bin/env bats

# /proc/sys/net/ipv4/tcp_fin_max_syn_backlog 12345
@test "set a param with a single value via lwrp (net.ipv4.tcp_max_syn_backlog)" {
  run cat /proc/sys/net/ipv4/tcp_max_syn_backlog
  [ "$output" -eq 12345 ]
}

# test
@test "set a param with a value range via lwrp (net.ipv4.tcp_rmem)" {
  run cat /proc/sys/net/ipv4/tcp_rmem
  [ "$output" = "4096	16384	33554432" ]
}
