##################################################
# Import jobs into a new Jenkins server
##################################################

# Look in two places for jobs: 
# The cookbook's template directory
# OR a drop directory where files have been pre-put
job_dirs = []
toolchain_jobs = []
job_dirs << jenkins_jobs_dir = "#{node['toolchain']['home']}/jenkins/jobs"
job_dirs << jenkins_template_dir = "/var/chef/cookbooks/toolchain/templates/jenkins/jobs"

directory jenkins_jobs_dir do
  action :nothing
  recursive true
end.run_action(:create)

job_dirs.each do |dir|
  Dir.entries(dir).each do |myd|
    toolchain_jobs << myd if File.exists?("#{dir}/#{myd}/config.xml")
    Chef::Log.debug(toolchain_jobs.inspect)
  end
end

toolchain_jobs.each do |job_name|
  jenkins_job job_name do
    config "#{jenkins_jobs_dir}/#{job_name}/config.xml"
    action :create
  end

  template "#{jenkins_jobs_dir}/#{job_name}/config.xml" do
    source "#{job_name}/config.xml"
    notifies :update, "jenkins_job[#{job_name}]", :immediately
    notifies :build,  "jenkins_job[#{job_name}]", :immediately
    only_if {File.exists?("jenkins_template_dir/#{job_name}/config.xml")}
  end
end
