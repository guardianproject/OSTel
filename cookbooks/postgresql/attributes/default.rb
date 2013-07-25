#
# Cookbook Name:: postgresql
# Attributes:: postgresql
#
# Copyright 2008-2009, Opscode, Inc.
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

case platform
when "debian"

  if platform_version.to_f == 5.0
    default[:postgresql][:version] = "8.3"
  elsif platform_version =~ /squeeze/
    default[:postgresql][:version] = "8.4"
  end

  set[:postgresql][:dir] = "/etc/postgresql/#{node[:postgresql][:version]}/main"

when "ubuntu"

  case
  when platform_version.to_f <= 9.04
    default[:postgresql][:version] = "8.3"
  else
    default[:postgresql][:version] = "9.2"
  end

  set[:postgresql][:dir] = "/etc/postgresql/#{node[:postgresql][:version]}/main"

when "fedora"

  if platform_version.to_f <= 12
    default[:postgresql][:version] = "8.3"
  else
    default[:postgresql][:version] = "8.4"
  end

  set[:postgresql][:dir] = "/var/lib/pgsql/data"

when "redhat","centos","scientific","amazon"

  default[:postgresql][:version] = "8.4"
  set[:postgresql][:dir] = "/var/lib/pgsql/data"

when "suse"

  if platform_version.to_f <= 11.1
    default[:postgresql][:version] = "8.3"
  else
    default[:postgresql][:version] = "8.4"
  end

  set[:postgresql][:dir] = "/var/lib/pgsql/data"

else
  default[:postgresql][:version] = "8.4"
  set[:postgresql][:dir]         = "/etc/postgresql/#{node[:postgresql][:version]}/main"
end

# Postgresql tuning and optimization

default[:postgresql][:default_statistics_target]=100
default[:postgresql][:max_fsm_pages]=500000
default[:postgresql][:max_fsm_relations]=10000
default[:postgresql][:logging_collector]="on"
default[:postgresql][:log_rotation_age]="1d"
default[:postgresql][:log_rotation_size]="100MB"
default[:postgresql][:checkpoint_timeout]="5min"
default[:postgresql][:checkpoint_completion_target]=0.5
default[:postgresql][:checkpoint_warning]="30s"
default[:postgresql][:checkpoint_segments]=100
default[:postgresql][:wal_buffers]="8MB"
default[:postgresql][:wal_writer_delay]="200ms"
default[:postgresql][:max_stack_depth]="7MB"
default[:postgresql][:total_memory]=node[:memory][:total].to_i * 1024
default[:postgresql][:total_memory_mb]=(node[:memory][:total].to_i * 1024) / 1024 / 1024
default[:postgresql][:shared_memory_percentage]=0.25
default[:postgresql][:effective_cache_size_percentage]=0.80
default[:postgresql][:shared_buffers]=((node[:memory][:total].to_i * 1024) / 1024 / 1024 * 0.25).to_i
default[:sysctl][:shared_buffers]=node[:memory][:total].to_i * 1024
default[:postgresql][:effective_cache_size]=((node[:memory][:total].to_i * 1024) * 0.80).to_i / 1024 / 1024
if node[:memory][:total].to_i < 5147483648
  default[:postgresql][:maintenance_work_mem]="128MB"
  default[:postgresql][:work_mem]="32MB"
else
  default[:postgresql][:maintenance_work_mem]="256MB"
  default[:postgresql][:work_mem]="64MB"
end

# Server Settings
default[:postgresql][:data_path]="/var/lib/postgresql"
default[:postgresql][:data_directory]="#{[node[:postgresql][:data_path]]}/#{[node[:postgresql][:version]]}/data"
default[:postgresql][:wal_directory]="#{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/pg_xlog"
default[:postgresql][:hba_file]="#{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/data/pg_hba.conf"
default[:postgresql][:ident_file]="#{node[:postgresql][:data_path]}/pg_ident.conf"
default[:postgresql][:external_pid_file]="#{node[:postgresql][:data_path]}/#{node[:postgresql][:version]}/postgresql.pid"
default[:postgresql][:temp_tablespaces]="/var/tmp/postgresql"
default[:postgresql][:local_authentication]="trust"
default[:postgresql][:encoding]="UTF8"
default[:postgresql][:locale]="en_US.UTF-8"
default[:postgresql][:text_search_config]="pg_catalog.english"
default[:postgresql][:max_connections]="65535"
# Hot standby Settings
default[:postgresql][:wal_level]="hot_standby"
default[:postgresql][:hot_standby]="on"
default[:postgresql][:hot_standby_feedback]="on"
default[:postgresql][:replicas]=["10.0.0.0/8"]
default[:postgresql][:allow]={ "10.0.0.0/8" => "md5" }
# Misc Settings
default[:postgresql][:swappiness]="15"
default[:postgresql][:kernel_sem]="4096 6553555 1600 65535"
default[:postgresql][:temp_buffers]="8MB"
default[:postgresql][:overcommit]=0
