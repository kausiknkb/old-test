Cookbook - Zabbix Server 2.2.2 + MySQL
===============

Author: Rafael Mantellatto (mantellatto@gmail.com)

Cookbook install and configure: Zabbix Server 2.2.2 + MySQL

Test: Ubuntu Server 12.04.3 LTS

Database Name: zabbixdb (user: zabbix / pass: zabbix)

Root MySQL password: zabbix

Zabbix Interface: admin / zabbix

HowTo
------------

* Install GIT Client

  \# apt-get update

  \# apt-get install git-core

* Install Chef Solo

  \# curl -L https://www.opscode.com/chef/install.sh | bash

* Download and configure CHEF-REPO structure

  \# wget http://github.com/opscode/chef-repo/tarball/master
  
  \# tar -zxvf master
  
  \# mv opscode-chef-repo-f9d4b0c/ /opt/chef-repo
  
  \# mkdir /opt/chef-repo/.chef

* Configure cookbook path (/opt/chef-repo/.chef/knife.rb) - Add line

  cookbook_path [ '/opt/chef-repo/cookbooks' ]
  
* Configure solo.rb (/opt/chef-repo/solo.rb) - Add lines

  file_cache_path "/opt/chef-solo"
  
  cookbook_path "/opt/chef-repo/cookbooks"

* Download cookbook

  \# git clone https://github.com/mantellatto/chef_zabbix.git -l /opt/chef-repo/cookbooks/zabbix

* Create your json (/opt/chef-repo/zabbix.json) - Add line

  { "run_list": [ "recipe[zabbix]" ] }

* Execute CHEF-SOLO

  \# chef-solo -c /opt/chef-repo/solo.rb -j /opt/chef-repo/zabbix.json

* Status service

  \# ps -ef | grep zabbix
  
* Zabbix Interface

  http://[IP]/zabbix

