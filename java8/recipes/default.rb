#
# Cookbook Name:: tomcat8
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "install_java8" do
    command "rpm -U #{Chef::Config[:file_cache_path]}/jdk-8u25-linux-x64.rpm"
    action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/jdk-8u25-linux-x64.rpm" do
    source "https://s3.amazonaws.com/broadspring-chef/software/jdk-8u25-linux-x64.rpm"
    action :create
    notifies :run, "execute[install_java8]", :immediately
end
