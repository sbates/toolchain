#################################################
# Set up Subversion for managing new and updated
# Jenkins jobs in an established environment
################################################# 
directory "#{node['jenkins']['node']['home']}/svn/#{node['subversion']['repo_name']}" do
  action :nothing
  owner node['jenkins']['server']['user']
  group node['jenkins']['server']['group']
  recursive true
end.run_action(:create)

subversion "jenkins_toolchain_setup" do
  repository "http://localhost/#{node['subversion']['repo_name']}"
  revision "HEAD"
  destination "#{node['jenkins']['node']['home']}/svn/#{node['subversion']['repo_name']}"
  svn_info_args "--config-dir /home/jenkins --non-interactive"
  svn_arguments "--config-dir /home/jenkins --non-interactive"
  svn_username node['subversion']['user']
  svn_password node['subversion']['user']
  user node['jenkins']['server']['user']
  group node['jenkins']['server']['group']
  action :checkout
end

##################################################
# Import jobs from Chef into a new Jenkins server
# Comes with one existing job for managing backups 
# as created above
##################################################

directory "#{node['jenkins']['node']['home']}/jobs" do
  action :nothing
  owner node['jenkins']['server']['user']
  group node['jenkins']['server']['group']
  recursive true
end.run_action(:create)

%w{jobs_backup}.each do |job|
  jenkins_job job do
    config "#{node['jenkins']['node']['home']}/jobs/#{job}-config.xml"
    action :nothing
  end

  template "#{node['jenkins']['node']['home']}/jobs/#{job}-config.xml" do
    source "#{job}.xml.erb"
    owner node['jenkins']['server']['user']
    group node['jenkins']['server']['group']
    notifies :update, "jenkins_job[#{job}]", :immediately
    notifies :build,  "jenkins_job[#{job}]", :immediately
  end
end
