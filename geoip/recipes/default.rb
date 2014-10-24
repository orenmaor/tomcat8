#
# Cookbook Name:: geoip
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "perl-HTTP-Request-Params" do
  action :install
end

package "perl-PerlIO-gzip" do 
  action :install
end

directory "/usr/local/share/GeoIP/" do
  owner "root"
  group "root"
  mode 0775
end

template "/usr/local/etc/GeoIP.conf" do
  source "GeoIP.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/usr/bin/geoip-update" do
  source "geoip-update.erb"
  owner "root"
  group "root"
  mode 0775
end

template "/etc/cron.d/geoip" do
  source "geoip-cron.erb"
  owner "root"
  group "root"
  mode 0644
end
