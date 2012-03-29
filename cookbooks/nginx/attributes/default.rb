default[:nginx][:domain] = node[:fqdn]
default[:nginx][:ssldir] = "/etc/nginx/ssl"
default[:nginx][:webapp_root] = "/usr/local/freeswitch/webapp/public"
