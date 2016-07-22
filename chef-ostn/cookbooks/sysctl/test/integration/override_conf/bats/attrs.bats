#!/usr/bin/env bats

# /proc/sys/net/ipv4/tcp_fin_timeout 29
@test "net.ipv4.tcp_fin_timeout was updated in /proc" {
  run cat /proc/sys/net/ipv4/tcp_fin_timeout
  [ "$output" -eq 29 ]
}
#     /proc/sys/vm/swappiness 19
@test "vm.swappiness was updated in /proc" {
  run cat /proc/sys/vm/swappiness
  [ "$output" -eq 19 ]
}
