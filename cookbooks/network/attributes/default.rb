#
# Cookbook Name:: network
# Attributes:: default
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
#

# In case we want to use similar attributes on both linux and windows (it cound happen)
case node["platform"]
  when "windows"
  default['network']['domain_controller'] 	= false
  default['network']['unc_host'] 		= "somehost"
  default['network']['share_path'] 		= "some\path\to\somewhere\"
  default['network']['domain_file'] 		= "somefilename.txt"
  default['network']['user']			= "SuperAdmin"
  default['network']['group']			= "SuperGroup"
end

default['network']['dns_ip'] 			= "192.168.234.132"
default['network']['OU']			= "OU=vCloud,DC=rundeck,DC=com"
default['network']['domain_name']		= "rundeck.com"
