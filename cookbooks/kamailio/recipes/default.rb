#
# Cookbook Name:: kamailio
# Recipe:: default
#
# Copyright 2013, Lee Azzarello <lee@guardianproject.info>
#
# GPLv3
#

# Add Kamailio package source to the system's database

execute "apt-key-add" do
  command "apt-key add /tmp/kamkey.gpg"
  action :nothing
end

cookbook_file "/tmp/kamkey.gpg" do
  source "kamailiodebkey.gpg"
  notifies :run, "execute[apt-key-add]", :immediately
end

execute "apt-get-update" do
  command "apt-get update"
  action :nothing
end

template "/etc/apt/sources.list.d/kamailio.list" do
  source "kamailio.list.erb"
  notifies :run, "execute[apt-get-update]", :immediately
end

# install kamailio and friends

package "kamailio"
package "kamailio-tls-modules" #essential
package "kamailio-utils-modules" # some non-SIP related utility functions
package "kamailio-presence-modules" # might as well support SIP presence
package "kamailio-xmpp-modules" # support an XMPP gateway
# database package is in another recipe...for now require postgres because it's
# rad.
package "rtpproxy" # default configuration is fine

# there are two configuration files required for kam

template "/etc/kamailio/kamailio.cfg" do
  source "kamailio.cfg.erb"
end

template "/etc/kamailio/tls.cfg" do
  source "tls.cfg.erb"
end

# define the service
service "kamailio" do
  supports :restart => true, :start => true
  action :nothing
end

# kam is disabled by default, which is good because at this point it won't start
# anyway because the database is not set up. This template changes the default
# to enable
template "/etc/default/kamailio" do
  source "kamailio.default.erb"
end

# configure some system attributes for the kamctl utility, which we'll use a
# little later.
template "/etc/kamailio/kamctlrc" do
  source "kamctlrc.erb"
end
