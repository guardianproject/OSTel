#
# Cookbook Name:: kamailio
# Recipe:: postgresql_mod
#
# Copyright 2013, Lee Azzarello <lee@guardianproject.info>
#
# GPLv3
#
#
# let's create our database before we install the Kam driver
# The test is if the package's DDL files exist locally
# assume postgres is already installed
package "kamailio-postgres-modules"

# now we have the DDL on disk but no database yet. make one

execute "create-database" do
  command "createdb #{node[:kamailio][:dbname]}"
  user "postgres"
  not_if "test -d #{node[:kamailio][:postgresql_schema_dir]}"
end

# install the kamailio driver
package "kamailio-postgres-modules"

