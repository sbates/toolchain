#
# Cookbook Name:: hosts
# Recipe:: cmf_hosts
#
# Copyright 2011, vmware
#
# All rights reserved - Do Not Redistribute


node['hosts']['cmf_hosts'].each do |k,v|
  hosts_entry k do
    ip v
    comment "a CMF server"
  end
end