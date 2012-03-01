remote_directory "c:/freesshd" do
  source "freesshd"
  notifies :create, 'powershell[configure_sshd_service]'
end

#windows_package "freeSSHd 1.2.6" do
#  source "http://www.freesshd.com/freeSSHd.exe"
#  options "/silent /SUPPRESSMSGBOXES"
#  action :install
#end 

powershell "configure_sshd_service" do
  code <<-EOH
    Invoke-Item c:/freesshd/FreeSSHDService.exe /Service"
    Set-Service FreeSSHDService -startuptype "automatic"| Where-Object {$_.status -eq "stopped" -and $_name -eq "FreeSSHDService"}
    EOH
  action :nothing
end

service "FreeSSHDService" do
  action :start
end
