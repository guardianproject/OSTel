#
# Cookbook Name:: test_sysctl
# Recipe:: default
#
# Copyright (C) 2013 OneHealth Solutions, Inc.
# 
# All rights reserved - Do Not Redistribute
#
include_recipe "sysctl"

sysctl_param 'net.ipv4.tcp_max_syn_backlog' do
  value 12345
end

sysctl_param 'net.ipv4.tcp_rmem' do
  value "4096 16384 33554432"
end

# remove sysctl parameter and set net.ipv4.tcp_fin_timeout back to default
#sysctl_param 'net.ipv4.tcp_fin_timeout' do
#  action :remove
#end
