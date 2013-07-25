#!/usr/bin/env bats
@test "postgresql is installed" {
[ -x "/usr/bin/psql" ]
}
@test "postgresql should have a pid file" {
[ -f "/var/run/postgresql/9.2-main.pid" ]
}
@test "apt.postgresql.org should have a list file" {
[ -f "/etc/apt/sources.list.d/apt.postgresql.org.list" ]
}
@test "it should be 9.2" {
psql --version | grep 'psql (PostgreSQL) 9.2'
}
