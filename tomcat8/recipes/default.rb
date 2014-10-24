#
# Cookbook Name:: tomcat8
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java8"
include_recipe "geoip"

execute "install_tomcat" do
    command "tar -C /opt/ -xvf #{Chef::Config[:file_cache_path]}/apache-tomcat-8.tar.gz"
    action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/apache-tomcat-8.tar.gz" do
    source "https://s3.amazonaws.com/broadspring-chef/software/apache-tomcat-8.0.14.tar.gz"
    action :create
    notifies :run,"execute[install_tomcat]", :immediately
end

link "/opt/tomcat" do
    to "/opt/apache-tomcat-8.0.14" 
end

execute "clean_tomcat" do
  command "rm -rf /opt/tomcat/webapps/*"
  action :nothing
end

user "tomcat" do
  uid 6000
  home "/opt/tomcat"
  system true
  shell "/bin/bash"
  notifies :run,"execute[clean_tomcat", :immediately
end

group "tomcat" do
  action :create
  gid 6000
  members "tomcat"
  append true
end

execute "tomcat_owner" do
  command "chown -R tomcat:tomcat /opt/*tomcat*"
end

template "/etc/init.d/tomcat" do
  source "tomcat8.sh.erb" 
  owner "root"
  group "root"
  mode 0750
end

service "tomcat" do
  action :enable
  supports :status => true, :restart => true, :stop => true, :start => true
end
