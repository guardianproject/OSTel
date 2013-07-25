case node['platform_family']
when "debian"
require_recipe "postgresql::client_debian"
end
