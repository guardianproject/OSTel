
postgres_info = node['postgresql'].current_override || node['postgresql'].current_default
backup_info = postgres_info['backup']
backup_generate_config node.name do
  template 'backup_config.rb.erb'
end

backup_install node.name 
package "libxml2-dev"
package "libxslt1-dev"
gem_package "fog" do
  version "~> 1.4.0"
end

cf = cookbook_file "/etc/chef/databag_key" do
  source 'databag_key'
end
cf.run_action(:create)
secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/databag_key")
environment = node.chef_environment
aws = Chef::EncryptedDataBagItem.load("aws", environment, secret)

backup_info['s3_path'] = backup_info['s3_path'].join('_') + '/' if backup_info['s3_path'].instance_of?(Array)
backup_generate_model "pg" do
  schedule backup_info['schedule']
  mailto backup_info['mailto']
  description "postgres backup"
  backup_type "database"
  database_type "PostgreSQL"
  split_into_chunks_of 2048
  store_with({"engine" => "S3", "settings" => { "s3.access_key_id" => aws['aws_access_key_id'], "s3.secret_access_key" => aws['aws_secret_access_key'], "s3.region" => "us-east-1", "s3.bucket" => backup_info['s3_bucket'], "s3.path" => backup_info['s3_path'], "s3.keep" => 10 } } )
  options("dbs" => postgres_info['dbs'].each)
  action :backup
end
