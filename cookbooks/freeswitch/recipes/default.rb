## Cookbook Name:: freeswitch
## Recipe:: default
##
## Copyright 2012, "Twelve Tone Software" <lee@twelvetone.info>
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
## ZRTP media pass-through proxy mode

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

# get source
execute "git_clone" do
  command "git clone #{node[:freeswitch][:git_uri]}"
  cwd "/usr/local/src"
  creates "/usr/local/src/freeswitch"
end

# compile source
script "compile_freeswitch" do
  interpreter "/bin/bash"
  cwd "/usr/local/src/freeswitch"
  script <<-EOF
  ./bootstrap.sh
  ./configure
  make clean
  make
EOF
  not_if "test -d /usr/local/freeswitch/bin/freeswitch"
end

# install software
execute "install_freeswitch" do
  cwd "/usr/local/src/freeswitch"
  command "make install"
  not_if "test -d /usr/local/freeswitch/bin/freeswitch"
end

# set global variables
template "/usr/local/freeswitch/conf/vars.xml" do
  source "vars.xml.erb"
  mode 0644
end

# set SIP security attributes
template "/usr/local/freeswitch/conf/sip_profiles/internal.xml" do
  source "internal.xml.erb"
  mode 0644
end
