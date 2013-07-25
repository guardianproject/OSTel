apt_repository "apt.postgresql.org" do
  uri "http://apt.postgresql.org/pub/repos/apt"
  distribution node['lsb']['codename'] + "-pgdg"
  components %w(main)
  key "http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc"
  deb_src true
  action :add
end

file "/etc/apt/sources.list.d/postgresql-9.2-source.list" do
  action :delete
  only_if { ::File.exists?("/etc/apt/sources.list.d/postgresql-9.2-source.list") }
end
