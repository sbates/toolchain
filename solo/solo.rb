log_level        :info
log_location     STDOUT

file_cache_path   "/var/chef/cache"
file_backup_path  "/var/chef/backup"
cache_options     ({:path => "/var/chef/cache/checksums", :skip_expires => true})

cookbook_path "/var/chef/cookbooks"
recipe_url "http://s3.amazonaws.com/bratty_packages/cookbooks.tgz"
