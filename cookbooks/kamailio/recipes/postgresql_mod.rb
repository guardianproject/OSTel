#
# Cookbook Name:: kamailio
# Recipe:: postgresql_mod
#
# Copyright 2013, Lee Azzarello <lee@guardianproject.info>
#
# GPLv3
#
#
# assume postgres is already installed
package "kamailio-postgres-modules"

# now we have the DDL on disk but no database yet. make one

execute "create-database" do
  command "createdb #{node[:kamailio][:dbname]}"
  creates "file on disk"
  user "postgres"
end


