maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "A convenient Chef LWRP to manage user accounts and SSH keys (this is not the opscode users cookbook)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

supports "ubuntu"
supports "debian"
supports "mac_os_x"
supports "suse"
supports "amazon"

recipe "user", "Processes a list of users with node config file."