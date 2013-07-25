#!/usr/bin/env bats
@test "vm.overcommit_ratio should be 100" {
[ "$(cat /proc/sys/vm/overcommit_ratio)" == 100 ]
}
@test "vm.overcommit_memory should be 2" {
[ "$(cat /proc/sys/vm/overcommit_memory)" == 2 ]
}
