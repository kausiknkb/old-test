#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2013, teamLab Inc
#
# All rights reserved - Do Not Redistribute
#

case node["platform"]
when "centos", "redhat", "amazon"
  remote_file "#{Chef::Config[:file_cache_path]}/#{node['zabbix']['repo']}" do
    source node['zabbix']['repo_url']
    action :create
    notifies :install, "rpm_package[zabbix-release]", :immediately
  end

  rpm_package "zabbix-release" do
    action :nothing
    source "#{Chef::Config[:file_cache_path]}/#{node['zabbix']['repo']}"
  end
end

