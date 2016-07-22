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
execute "create-database" do
  command "createdb #{node[:kamailio][:dbname]}"
  user "postgres"
  not_if "test -d #{node[:kamailio][:postgresql_schema_dir]}"
end

# install the kamailio driver
package "kamailio-postgres-modules"

# great! we have DDL. Let's load it.
#
%w{
  standard-create.sql
  auth_db-create.sql
  alias_db-create.sql
  domain-create.sql
}.each do |sqlfile|
  # we need the name of the table to test for existence. Regex hack to the
  # rescue!
  # read line by line and run the regex over each line, if the match object is
  # not nil, put the matching string into an array, which will later flatten to
  # generate SQL
  table_names = []
  File.open("#{node[:kamailio][:postgresql_schema_dir]}/#{sqlfile}") do |f|
    while line = f.gets
      matches = /CREATE TABLE (.+)* \(/.match line
      if matches
        if (matches[1].nil?)
          next
        else
          table_names << matches[1]
        end
      end
    end
  end
  
  predicate = ""
  if table_names.size > 1
    table_names.each_index do |i|
      table_names[i] = "tablename = \'#{table_names[i]}\'"
    end
    predicate = table_names.join(" OR ")
  else
    predicate = "tablename = \'#{table_names[0]}\'"
  end

  execute sqlfile do
    command "psql -d #{node[:kamailio][:dbname]} -f #{node[:kamailio][:postgresql_schema_dir]}/#{sqlfile}"
    user "postgres"
    not_if do
      tables = `psql -Aqt -d #{node[:kamailio][:dbname]} -c \"SELECT tablename FROM pg_tables WHERE #{predicate}\"` 
      if tables.split("\n").size == table_names.size
        return true
      else
        return false
      end
    end
  end
end
