#
# Cookbook Name:: zabbix
# Recipe:: server
#
# Copyright 2013, teamLab Inc
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'zabbix'

%w(
  zabbix
  httpd24
  httpd24-devel
  mod24_ssl
  php54
  php54-devel
  php54-mysql
  mysql51-libs
  zabbix-web
  zabbix-web-mysql
  zabbix-web-japanese
  zabbix-server-mysql
  zabbix-server
).each do |pkg|
  package pkg
end

template '/etc/zabbix/zabbix_server.conf' do
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[zabbix-agent]'
end

template '/etc/logrotate.d/zabbix-server' do
  owner 'root'
  group 'root'
  mode 00644
  source 'zabbix-server_logrotate.erb'
end

bash 'database schema setup' do
  user "root"
  group "root"
  cwd "/usr/share/doc/zabbix-server-mysql-#{node['zabbix']['version']}/create"
  code <<-EOC
    mysql -u #{node['zabbix']['server']['db']['user']} -p#{node['zabbix']['server']['db']['password']} #{node['zabbix']['server']['db']['name']}  < schema.sql 
    mysql -u #{node['zabbix']['server']['db']['user']} -p#{node['zabbix']['server']['db']['password']} #{node['zabbix']['server']['db']['name']} < images.sql
    mysql -u #{node['zabbix']['server']['db']['user']} -p#{node['zabbix']['server']['db']['password']} #{node['zabbix']['server']['db']['name']} < data.sql
  EOC
  not_if "mysql -u #{node['zabbix']['server']['db']['user']} -p#{node['zabbix']['server']['db']['password']} #{node['zabbix']['server']['db']['name']} -e 'select * from item_discovery where itemdiscoveryid = 1;' | grep itemdiscoveryid"
end

service 'zabbix-server' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
