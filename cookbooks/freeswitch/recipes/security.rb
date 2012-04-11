## Install OS level security requirements
package "aide"

template "aide.conf" do
  source "aide.conf.erb"
  # notifies :run, "execute[aide_update]"
end

execute "aideinit" do
  command "aideinit"
  creates "/var/lib/aide/aide.db"
end

execute "aide_update" do
  action :nothing
  command "aide --update"
end
