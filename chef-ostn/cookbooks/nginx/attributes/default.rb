default[:nginx][:domain] = node[:fqdn]
default[:nginx][:ssldir] = "/etc/nginx/ssl"
default[:nginx][:webapp_root] = "/usr/local/freeswitch/webapp/public"
default[:nginx][:cert_config_file] = "config.tpl"
default[:nginx][:cert_ou] = "Example Organization"
default[:nginx][:cert_country] = "US"
default[:nginx][:cert_locality] = "Some City"
default[:nginx][:cert_email] = "mail@example.com"
