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
tarball = "apache-tomcat-#{tomcat_version}.tar.gz"
download_file = "#{node['tomcat']['download_server']}dist/tomcat/tomcat-#{major_version}/v#{tomcat_version}/bin/apache-tomcat-#{tomcat_version}.tar.gz"

# Create group
group 'add_tomcat_grp' do
  group_name 'tomcat'
  action :create
end

# Create user
user 'tomcat' do
  comment 'tomcat user'
  group 'tomcat'
  system true
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

# Install Java
yum_package 'install_java' do
  package_name 'java-1.8.0-openjdk-devel'
  action :install
end

# Install wget
yum_package 'install_wget' do
  package_name 'wget'
  action :install
end

# Install unzip
yum_package 'install unzip' do
  package_name 'unzip'
  action :install
end

# Download and unpack tomcat
remote_file "/tmp/#{tarball}" do
  source download_file
  action :create_if_missing
  mode 00644
end

execute 'tar-file' do
  command 'sudo tar xvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'
  action :run
end

directory '/opt/tomcat' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  recursive true
  action :create
end

directory '/opt/tomcat/conf' do
  owner 'tomcat'
  group 'tomcat'
  mode '0750'
  recursive true
  action :create
end

# Update each directory owner and group to tomcat and verify permissions
%w(/opt/tomcat/webapps /opt/tomcat/work /opt/tomcat/temp /opt/tomcat/logs).each do |path|
  directory path do
    owner 'tomcat'
    group 'tomcat'
    mode '0750'
  end
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat-systemd.erb'
  mode '0440'
  owner 'root'
  group 'root'
end

service 'tomcat' do
  supports restart: true
  action :enable
  subscribes :restart, 'template[/etc/systemd/system/tomcat.service]', :delayed
end
