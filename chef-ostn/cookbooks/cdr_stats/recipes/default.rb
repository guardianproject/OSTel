package "mercurial"
package "python2.6"
package "python-flup"
python_package "pip"


template "requirements.txt" do
  source "requirements.txt.erb"
end

cookbook_file "schema.sql" do
  source "schema.sql"
end

template "/usr/local/freeswitch/conf/cdr_sqlite.conf.xml" do
  source "fs_cdr_sqlite.conf.xml.erb"
end
