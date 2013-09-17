#
# Cookbook Name:: ostn
# Recipe:: default
#
# Copyright 2012, Twelve Tone Software
#
# GPL version 2 placeholder
# https://www.gnu.org/licenses/gpl2.txt
#

package "readline6-dev"
gem_package "bundler"

# the freeswitch cookbook must be run before this resource
# get source
execute "git_clone" do
  command "git clone #{node[:ostn][:git_uri]}"
  cwd "/usr/local/src"
  creates "/usr/local/src/OSTel"
end

# copy source directory without git repo to /usr/local/freeswitch

execute "bundle_install" do
	command "bundle install"
	cwd "/usr/local/freeswitch/webapp"
end
