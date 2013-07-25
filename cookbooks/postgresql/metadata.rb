name "postgresql"
maintainer        "Scott M. Likens"
maintainer_email  "scott@likens.us"
license           "Apache 2.0"
description       "Installs and configures postgresql for clients or servers"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.1"
recipe            "postgresql", "Includes postgresql::client"
recipe            "postgresql::client", "Installs postgresql client package(s)"
recipe            "postgresql::server", "Installs postgresql server packages, templates"
recipe            "postgresql::server_redhat", "Installs postgresql server packages, redhat family style"
recipe            "postgresql::server_debian", "Installs postgresql server packages, debian family style"

supports "ubuntu"
supports "debian"

depends "apt"
depends "openssl"
depends "sysctl"
