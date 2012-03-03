# Author:: Sascha Bates
# Cookbook Name:: network
# Recipe:: windows
#
# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Check if node is a domain controller
# This defaults to false and would need 
# an explicit set to true in the node.json

if node['network']['domain_controller']
  windows_batch "promote_to_domain_controller" do
    command "dcpromo /answer:\\#{node.network.unc_host}\#{node.network.share_path}\#{node.network.domain_file}"
    user "someuser" #if different from whatever we're logged in as; otherwise delete these lines
    group "somegroup"
    only_if "here we give it a condition to check like Registry.value_exists?('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run','BGINFO')"
  end

  # if it's not a domain controller
  # let's join the domain
  else
    windows_batch "set_dns" do
      command "netsh int ip set dns "local area connection" static #{node.network.dns_ip} primary"
      user "someuser"
      group "somegroup"
      not_if "check the registry key or file for dns settings?"
    end
 
    windows_batch "join_domain" do 
      command "netdom join %COMPUTERNAME% /domain:#{node.network.domain_name} /ou:#{node.network.OU} /userd:rundeck\administrator /passwordd:*** /reboot
      user "someuser"
      group "somegroup"
      only_if "some check set here"
      notifies :request, 'windows_reboot[60]'
    end
end

windows_reboot 60 do
  reason 'reboot after network setup'
  action :nothing
end
