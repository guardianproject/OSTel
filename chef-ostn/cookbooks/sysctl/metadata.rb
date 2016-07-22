name             "sysctl"
maintainer       "OneHealth Solutions, Inc."
maintainer_email "cookbooks@onehealth.com"
license          "Apache v2.0"
description      "Configures sysctl parameters"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.3"
supports 'ubuntu', ">= 10.04"
supports 'centos', ">= 5.9"
%w(debian redhat).each do |os|
  supports os
end
conflicts "jn_sysctl"
conflicts "el-sysctl"
