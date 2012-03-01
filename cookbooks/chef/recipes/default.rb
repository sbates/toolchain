directory "/var/chef/cache" do
  action :nothing
  recursive true
end.run_action(:create)
