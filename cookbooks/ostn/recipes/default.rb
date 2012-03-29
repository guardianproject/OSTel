#
# Cookbook Name:: ostn
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

gem_package "unicorn"
gem_package "sinatra"
#
# get source
execute "git_clone" do
  command "git clone #{node[:ostn][:git_uri]}"
  cwd "/usr/local/freeswitch"
  creates "/usr/local/src/OSTel"
end
