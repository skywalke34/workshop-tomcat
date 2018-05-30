#
# Cookbook Name:: tomcat
# Recipe:: install_tomcat.rb
#
# Copyright (C) 2014 Roberto Moutinho
# Copyright (C) 2015 Sunggun Yu
# Copyright (C) 2018 Tracy Walker
#
# All rights reserved - Do Not Redistribute
#

# Set the download URL for tomcat version using attributes
tomcat_version = node['tomcat']['version']
major_version = tomcat_version[0]
#download_url = "#{node['tomcat']['download_server']}/dist/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz"
tarball = "apache-tomcat-#{tomcat_version}.tar.gz"
download_file = "#{node['tomcat']['download_server']}dist/tomcat/tomcat-#{major_version}/v#{tomcat_version}/bin/apache-tomcat-#{tomcat_version}.tar.gz"

# Create group
# group node['tomcat']['group']
group 'add_tomcat_grp' do
   group_name 'tomcat'
   action :create
end

# Create user
user 'tomcat' do
  comment 'tomcat user'
  group 'tomcat'
  system true
  password 'tomcat34!'
  home '/opt/tomcat'
  shell '/bin/bash'
  action :create
end

directory '/opt/tomcat' do
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
    action :create
end

#execute 'install_java' do
#    command 'sudo yum install java-1.7.0-openjdk-devel'

yum_package 'install_java' do
    package_name 'java-1.8.0-openjdk-devel'
    action :install
end

yum_package 'install_wget' do
    package_name 'wget'
    action :install
end

yum_package 'install unzip' do
    package_name 'unzip'
    action :install
end

# Download and unpack tomcat
#remote_file "#{Chef::config[:file_cache_path]}/#{tarball}"
remote_file "/tmp/#{tarball}" do
  source download_file
  action :create_if_missing
  mode 00644
end

execute 'tar-file' do
    command 'sudo tar xvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
    action :run
end

execute 'update-perm' do
    command 'sudo chgrp -R tomcat /opt/tomcat'
end

execute 'update-r-conf' do
    cwd '/opt/tomcat'
    command 'sudo chmod -R g+r conf'
    action :run
end

execute 'update-x-conf' do
    cwd '/opt/tomcat'
    command 'sudo chmod g+x conf'
    action :run
end

execute 'chown-directories' do
    cwd '/opt/tomcat'
    command 'sudo chown -R tomcat webapps/ work/ temp/ logs/' 
    action :run
end

template '/etc/systemd/system/tomcat.service' do
    source 'tomcat-systemd.erb'
    mode '0440'
    owner 'root'
    group 'root'
end

# Tomcat init script configuration
# template "/etc/init.d/tomcat#{major_version}" do
# source 'init.conf.erb'
# mode '0755'
#  owner node['tomcat']['user']
#  group node['tomcat']['group']
# end

# include_recipe 'tomcat::set_tomcat_home'

# Create default catalina.pid file to prevent restart error for 1st run of coookbook.
# file "#{node['tomcat']['tomcat_home']}/catalina.pid" do
#  owner node['tomcat']['user']
#  group node['tomcat']['group']
#  mode '0755'
#  action :create
#  not_if { ::File.exist?("#{node['tomcat']['tomcat_home']}/catalina.pid") }
# end

# Enabling tomcat service and restart the service if subscribed template has changed.
 # subscribes :restart, "template[#{node['tomcat']['tomcat_home']}/bin/setenv.sh]", :delayed
 # subscribes :restart, "template[#{node['tomcat']['tomcat_home']}/conf/server.xml]", :delayed
 # subscribes :restart, "template[/etc/init.d/tomcat#{major_version}]", :delayed

# systemd_unit 'tomcat.service' do
#     user 'root'
#     action :reload_or_restart
# end

service "tomcat" do
  supports :restart => true
  action :enable
  subscribes :restart, "template[/etc/systemd/system/tomcat.service]", :delayed
end
