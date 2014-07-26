#
# Cookbook Name:: zabbix
# Recipe:: agent
#
# Copyright 2013, teamLab Inc
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'zabbix'

%w(
  zabbix-agent
  zabbix-get
  zabbix-sender
).each do |pkg|
  package pkg
end

template '/etc/zabbix/zabbix_agentd.conf' do
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[zabbix-agent]'
end

template '/etc/logrotate.d/zabbix-agent' do
  owner 'root'
  group 'root'
  mode 00644
  source 'zabbix-agent_logrotate.erb'
end

directory '/etc/zabbix/externalscripts' do
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/etc/zabbix/externalscripts/zapache' do
  owner 'root'
  group 'root'
  mode 00755
end

service 'zabbix-agent' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
