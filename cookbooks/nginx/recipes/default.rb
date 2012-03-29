package "nginx"

service "nginx" do
  supports :restart => true, :start => true
  action [:enable]
end

directory "/etc/nginx/ssl" do
  action :create
  owner "www-data"
end

execute "gen_key" do
  command "openssl genrsa -out #{node[:nginx][:ssldir]}/genrsa.key 2048"
  creates "#{node[:nginx][:ssldir]}/genrsa.key"
end

execute "gen_self_signed" do 
  command "openssl req -new -x509 -batch -config #{node[:nginx][:ssldir]}/#{node[:nginx][:cert_config_file]} -key #{node[:nginx][:ssldir]}/genrsa.key -out #{node[:nginx][:ssldir]}/cert.pem -days 1095"
  creates "#{node[:nginx][:ssldir]}/cert.pem"
end

template "/etc/nginx/sites-available/default" do
  source "nginx-default.erb"
end
