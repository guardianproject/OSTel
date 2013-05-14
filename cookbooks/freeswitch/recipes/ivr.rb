## Cookbook Name:: freeswitch
## Recipe:: ivr_only
##
## Copyright 2013, "Lee Azzarello" <lee@guardianproject.info>
##
##    This program is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program.  If not, see <http://www.gnu.org/licenses/>.
##
#
## Freeswitch cookbook
## IVR Services only. This is useful if another application is used for SIP
## routing and registration

## Build requirements
package "autoconf" 
package "automake"
package "g++"
package "git-core"
package "libjpeg62-dev"
package "libncurses5-dev"
package "libtool"
package "make"
package "python-dev"
package "gawk"
package "pkg-config"
package "gnutls-bin"
package "libsqlite3-dev"

# get source
execute "git_clone" do
  command "git clone #{node[:freeswitch][:git_uri]}"
  cwd "/usr/local/src"
  creates "/usr/local/src/freeswitch"
end

template "#{node[:freeswitch][:path]}/modules.conf" do
  source "modules_ivr.conf.erb"
  owner node[:freeswitch][:user]
  group node[:freeswitch][:group]
end

# compile source and install
script "compile_freeswitch" do
  interpreter "/bin/bash"
  cwd "/usr/local/src/freeswitch"
  code <<-EOF
  git checkout #{node[:freeswitch][:release_tag]}
  ./bootstrap.sh
  ./configure --enable-zrtp
  make clean
  make
  make install
  make samples
EOF
  not_if "test -f #{node[:freeswitch][:path]}/freeswitch"
end

# install init script
template "/etc/init.d/freeswitch" do
  source "freeswitch.init.erb"
  mode 0755
end

# install defaults
template "/etc/default/freeswitch" do
  source "freeswitch.default.erb"
  mode 0644
end

group node[:freeswitch][:group] do
  action :create
end

# create non-root user
user node[:freeswitch][:user] do
  system true
  shell "/bin/bash"
  home node[:freeswitch][:homedir]
  gid node[:freeswitch][:group]
end

# define service
service node[:freeswitch][:service] do
  supports :restart => true, :start => true
  action [:enable]
end

# change ownership of homedir
execute "fs_homedir_ownership" do
  cwd node[:freeswitch][:homedir]
  command "chown -R #{node[:freeswitch][:user]}:#{node[:freeswitch][:group]} ."
end

# set global variables
template "#{node[:freeswitch][:homedir]}/conf/vars.xml" do
  owner node[:freeswitch][:user]
  group node[:freeswitch][:group]
  source "vars.xml.erb"
  mode 0644
end

# set SIP security attributes for registered users
template "#{node[:freeswitch][:homedir]}/conf/sip_profiles/internal.xml" do
  owner node[:freeswitch][:user]
  group node[:freeswitch][:group]
  source "internal.xml.erb"
  mode 0644
  notifies :restart, "service[#{node[:freeswitch][:service]}]"
end

template "#{node[:freeswitch][:homedir]}/conf/sip_profiles/internal-ipv6.xml" do
  owner node[:freeswitch][:user]
  group node[:freeswitch][:group]
  source "internal-ipv6.xml.erb"
  mode 0644
  notifies :restart, "service[#{node[:freeswitch][:service]}]"
end

# set SIP security attributes for external users
template "#{node[:freeswitch][:homedir]}/conf/sip_profiles/external.xml" do
  owner node[:freeswitch][:user]
  group node[:freeswitch][:group]
  source "external.xml.erb"
  mode 0644
  notifies :restart, "service[#{node[:freeswitch][:service]}]"
end

template "#{node[:freeswitch][:homedir]}/conf/dialplan/default.xml" do
  source "default.xml.erb"
  owner node[:freeswitch][:user]
  group node[:freeswitch][:group]
  mode 0755
end

#template "" do
#  source "modules.conf.xml.erb"
#  owner node[:freeswitch][:user]
#  group node[:freeswitch][:group]
#  mode 0644
#  notifies :restart, "service[#{node[:freeswitch][:service]}]"
#end
