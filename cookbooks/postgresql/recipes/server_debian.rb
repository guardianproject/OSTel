#
# Cookbook Name:: postgresql
# Recipe:: server
#
# Author:: Scott M. Likens (<scott@likens.us>)
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Lamont Granquist (<lamont@opscode.com>)
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe "postgresql::client"

# randomly generate postgres password
node.set_unless[:postgresql][:password] = secure_password
node.save unless Chef::Config[:solo]

cookbook_file "/etc/security/limits.d/postgres.conf" do
  source "postgres.conf"
end
require_recipe "postgresql::pgdg"
require_recipe "postgresql::client"

case node[:postgresql][:version]
when "8.3"
  node.default[:postgresql][:ssl] = "off"
else
  node.default[:postgresql][:ssl] = "true"
end


package "postgresql-server-dev-9.2"
package "postgresql-contrib-9.2"


service "postgresql" do
  case node['platform']
  when "ubuntu"
    case
     when node['platform_version'].to_f <= 10.04
       service_name "postgresql-#{node['postgresql']['version']}"
     else
       service_name "postgresql"
     end
  when "debian"
    case
     when platform_version.to_f <= 5.0
       service_name "postgresql-#{node['postgresql']['version']}"
     when platform_version =~ /squeeze/
       service_name "postgresql"
     else
       service_name "postgresql"
     end
  end
  supports :restart => true, :status => true, :reload => true
  action :stop
  not_if { File.exists?("/var/run/postgres.initdb.done") }
end

directory "/var/tmp/postgresql/#{node[:postgresql][:version]}/temp" do
  owner "postgres"
  group "postgres"
  mode 0600
  recursive true
  action :create
end

directory node['postgresql']['temp_tablespaces'] do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
  recursive true
end

directory node['postgresql']['dir'] do
  action :create
  recursive true
end

directory node['postgresql']['data_path'] do
  owner "postgres"
  group "postgres"
  action :create
  recursive true
end

template "#{node[:postgresql][:dir]}/postgresql.conf" do
  source "debian.postgresql.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  variables(
            :data_directory => "#{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/data",
            :hba_file => "/etc/postgresql/#{node[:postgresql][:version]}/main/pg_hba.conf",
            :ident_file => node[:postgresql][:ident_file],
            :external_pid_file => node[:postgresql][:external_pid_file],
            :shared_buffers => node[:postgresql][:shared_buffers],
            :work_mem => node[:postgresql][:work_mem],
            :maintenance_work_mem => node[:postgresql][:maintenance_work_mem],
            :max_stack_depth => node[:postgresql][:max_stack_depth],
            :wal_level => node[:postgresql][:wal_level],
            :temp_buffers => node[:postgresql][:temp_buffers],
            :wal_buffers => node[:postgresql][:wal_buffers],
            :wal_writer_delay => node[:postgresql][:wal_writer_delay],
            :checkpoint_segments => node[:postgresql][:checkpoint_segments],
            :checkpoint_timeout => node[:postgresql][:checkpoint_timeout],
            :hot_standby => node[:postgresql][:hot_standby],
            :hot_standby_feedback => node[:postgresql][:hot_standby_feedback],
            :effective_cache_size => node[:postgresql][:effective_cache_size],
            :default_statistics_target => node[:postgresql][:default_statistics_target],
            :logging_collector => node[:postgresql][:logging_collector],
            :log_rotation_age => node[:postgresql][:log_rotation_age],
            :log_rotation_size => node[:postgresql][:log_rotation_size],
            :temp_tablespaces => "/var/tmp/postgresql/#{node[:postgresql][:version]}/temp",
            :wal_level => node[:postgresql][:wal_level],
            :max_connections => node[:postgresql][:max_connections],
            :text_search_config => node[:postgresql][:text_search_config]
            )
#  notifies :restart, resources(:service => "postgresql")
end

template "#{node[:postgresql][:dir]}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  variables(
            :method => node[:postgresql][:local_authentication],
            :replica => node[:postgresql][:replicas],
            :allow => node[:postgresql][:allow].to_hash
            )
#  notifies :restart, resources(:service => "postgresql")
end

file "/var/run/postgres.initdb.done" do
  action :nothing
  owner "postgres"
  group "postgres"
end

file "#{node[:postgresql][:dir]}/.org_grok" do
  owner "postgres"
  mode 0600
  content node[:postgresql][:password].to_s
end

directory node['postgresql']['wal_directory'] do
  owner "postgres"
  group "postgres"
  action :create
  recursive true
end

# If we have a lost+found directory in the wal path let's make sure it's gone.
directory "#{node[:postgresql][:wal_directory]}/lost+found" do
  action :delete
  recursive true
end

sysctl "Raise kernel.shmmax" do
  variables 'kernel.shmmax' => node[:postgresql][:total_memory]
end

sysctl "Raise kernel.shmall" do
  variables 'kernel.shmall' => node[:postgresql][:total_memory] / 4096
  not_if { node[:postgresql][:total_memory]/4096 < 2097152 }
end

sysctl "Modify kernel.sem" do
  variables 'kernel.sem' => node[:postgresql][:kernel_sem]
end

sysctl "Swappiness of 15" do
  variables 'vm.swappiness' => node[:postgresql][:swappiness]
end

if node['postgresql']['overcommit'] == 2
  sysctl "vm.overcommit_memory" do
    variables 'vm.overcommit_memory' => 2
  end
  sysctl "vm.overcommit_ratio" do
    variables 'vm.overcommit_ratio' => 100
  end
  if Chef::Config[:solo]
    log "fs.file-max not available under lxc" do
      level :info
    end
  else
    sysctl "fs.file-max for postgres" do 
      variables 'fs.file-max' => 999999
    end
  end
end

execute "init-postgres" do
  command "/usr/lib/postgresql/9.2/bin/initdb -D #{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/data -X #{node[:postgresql][:wal_directory]} --pwfile=#{node[:postgresql][:dir]}/.org_grok --encoding=#{node[:postgresql][:encoding]} --locale=#{node[:postgresql][:locale]} -A #{node[:postgresql][:local_authentication]}"
  action :run
  user "postgres"
  not_if { FileTest.directory?("#{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/data") }
  notifies :create_if_missing, "file[/var/run/postgres.initdb.done]", :immediate
end


# NOTE: Not required
# template "#{node[:postgresql][:hba_file]}" do
#   source "pg_hba.conf.erb"
#   owner "postgres"
#   group "postgres"
#   mode 0600
#   variables(
#             :method => node[:postgresql][:local_authentication],
#             :replica => node[:postgresql][:replicas]
#             )
# #  notifies :reload, resources(:service => "postgresql"), :immediately
# end

execute "start postgresql" do
  command "/bin/bash --login -c 'LC_ALL="" /etc/init.d/postgresql start'"
  not_if 'ps aux | grep -v bash | grep [p]ostgres'
end

service "postgresql" do
  action :enable
end

