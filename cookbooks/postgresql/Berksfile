site :opscode

metadata

cookbook "build-essential"
cookbook "backup"
cookbook "openssl"
cookbook "python"
cookbook "sysctl", git: 'git://github.com/damm/sysctl.git'

group :integration do
  cookbook "apt"
  cookbook "yum"
  cookbook "minitest-handler"
end