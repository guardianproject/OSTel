name "postgresql_server"
description "Postgrsql Database Server Role"
run_list "recipe[postgresql::client]",
  "recipe[postgresql::server]"

default_attributes "postgresql" => {
  "data_directory" => "/var/lib/postgresql/9.2/data",
  "wal_directory" => "/mnt/wal",
  "temp_tablespaces" => "/mnt/postgresql/9.2/temp",
  "password" => "makeitagoodone",
  "replicas" => ["127.0.0.1/32"],
  "allow" => {"127.0.0.1/32" => "trust" }
}  
