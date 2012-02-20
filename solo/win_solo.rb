log_level        :debug
log_location     STDOUT

file_cache_path   "c:/chef/cache"
file_backup_path  "c:/chef/backup"
cache_options     ({:path => "c:/chef/cache/checksums", :skip_expires => true})

cookbook_path "c:/chef/cookbooks"
recipe_url "http://s3.amazonaws.com/Alex-SF-dev/cookbooks.tgz"
