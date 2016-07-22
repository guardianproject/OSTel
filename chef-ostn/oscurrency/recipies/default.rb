# oscurrency deps for Debian Squeeze

HOME = "/home/oscurrency/oscurrency"

user "oscurrency" do
  action :create
  homedir HOME
end

cookbook_file "#{HOME}/.bashrc" do
  source "bashrc.erb"
end

package "build-essential"
package "libssl-dev"
package "libreadline-dev"
package "libyaml-dev"

script "ruby 1.9.3" do

end

script "rubygems" do

end

package "postgresql-8.4"
package "postgresql-server-dev-8.4"
gem_package "bundler"

gem_package "rake" do
  version "0.9.2.2"
end

package "libmagickcore-dev"
package "libmagickwand-dev"

script "get-oscurrency" do

end

script "bundle-install" do
  cwd "#{HOME}/oscurrency"
  directory "vendor/bundle"
  command "bundle install --deployment"
end

template "#{HOME}/oscurrency/config/database.yml" do
  source "database.yml.erb"
end

# install the test-unit 1.2.3 gem or remove it from production dependencies
#
script "db-migrate" do
  cwd "#{HOME}/oscurrency"
  command "rake db:migrate"
  command "rake install"
end

# at this point the built in server fails because of a bunch of errors from the
# ActiveScaffold library. It is looking for a helper in app/helpers/admin/ for
# each data model. Perhaps there is an initialization step for this library?
