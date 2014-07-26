# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright (C) 2013 Sascha Bates
#

include_recipe 'logrotate'

package "httpd" 

#service "httpd" do
#	# If restarted/reloaded too quickly httpd has a habit of failing.
#	# This may happen with multiple recipes notifying httpd to restart - like
#	# during the initial bootstrap.
#	restart_command "/sbin/service httpd restart && sleep 1"
#	reload_command "/sbin/service httpd reload && sleep 1"#
#	supports [:restart, :reload, :status]
#	action :enable
#end

file "/etc/sysconfig/httpd" do
  content "HTTPD=#{node['httpd']['binary']}"
end

template "/etc/httpd/conf/httpd.conf" do
	source "httpd.conf.erb"
	mode 0644
	notifies :restart, "service[httpd]"
end

directory node['httpd']['docroot'] do
  group "apache"
    recursive true
end

# Rotate Logs
logrotate_app "httpd" do
  path node['httpd']['log_dir']
end

service "httpd" do
  # If restarted/reloaded too quickly httpd has a habit of failing.
  # This may happen with multiple recipes notifying httpd to restart - like
  # during the initial bootstrap.
  restart_command "/sbin/service httpd restart && sleep 1"
  reload_command "/sbin/service httpd reload && sleep 1"#
  supports [:restart, :reload, :status]
  action [:enable, :start]
end