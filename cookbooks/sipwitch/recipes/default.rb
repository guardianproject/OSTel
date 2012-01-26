#
# Cookbook Name:: sipwitch
# Recipe:: default
#
# Copyright 2012, Twelve Tone Software
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

package "curl"

execute "apt-get-update" do
  command "apt-get update"
  action :nothing
end

execute "add-sipwitch-key" do
  command "curl http://www.gnutelephony.org/archive/squeeze/public.key | apt-key add -"
  action :nothing
  notifies :run, "execute[apt-get-update]", :immediately
end

template "/etc/apt/sources.list.d/sipwitch.list" do
  source "sipwitch.list.erb"
  mode "0644"
  notifies :run, "execute[add-sipwitch-key]", :immediately
end

package "sipwitch"

service "sipwitch" do
  action [:enable]
  supports [:restart => true, :start => true]
end
 
template "/etc/sipwitch.conf" do
  source "sipwitch.conf.erb"
  mode "0600"
end

template "/etc/default/sipwitch" do
  source "default.erb"
  mode "0644"
  notifies :restart, "service[sipwitch]"
end
