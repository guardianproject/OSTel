#
# Cookbook Name:: kamailio
# Recipe:: postgresql_mod
#
# Copyright 2013, Lee Azzarello <lee@guardianproject.info>
#
# GPLv3
#
#
package "kamailio-postgres-modules"

# unpack a shitload of SQL
# push that SQL through a lib to execute it before starting Kamailio
