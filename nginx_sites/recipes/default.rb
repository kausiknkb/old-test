#
# Cookbook Name:: nginx_sites
# Recipe:: default
#
# Copyright 2013, Hirohide Sano <sanojimaru@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx'

node['nginx_sites']['sites'].each do |site|
  document_root = site['dir'] || "/var/www/#{site['name']}"

  template "#{site['name']}.conf" do
    path "#{node['nginx']['dir']}/conf.d/#{site['name']}.conf"
    source "#{site['type']}.conf.erb"
    variables :site => site, :document_root => document_root
    action :create
  end

  directory document_root do
    owner node['nginx']['user']
    group node['nginx']['group']
    mode 0755
    action :create

    not_if{ File.exists? document_root }
  end
end

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action :start
end
