default['httpd']['package'] = "httpd"
default['httpd']['dir'] = "/etc/httpd"
default['httpd']['log_dir'] = "/var/log/httpd"
default['httpd']['log_level'] = "warn"
default['httpd']['error_log'] = "error.log"
default['httpd']['user'] = "apache"
default['httpd']['group'] = "apache"
default['httpd']['binary'] = "/usr/sbin/httpd.worker"
default['httpd']['icondir'] = "/var/www/icons"
default['httpd']['cache_dir'] = "/var/cache/httpd"
default['httpd']['pid_file'] = "/var/run/httpd/httpd.pid"
default['httpd']['docroot'] = "/var/www/html"

# General settings - if these aren't set in the conf, the below numbers are the default
# Overrides will be set per app
default['httpd']['listen_ports'] = ["80"]
default['httpd']['contact'] = "root@localhost"
default['httpd']['timeout'] = 300
default['httpd']['keepalive'] = "On"
default['httpd']['keepaliverequests'] = 100
default['httpd']['keepalivetimeout'] = 5
default['httpd']['extendedstatus'] = "Off"

# Security
default['httpd']['servertokens'] = "Prod"
default['httpd']['serversignature'] = "On"

# Worker Attributes
default['httpd']['worker']['startservers'] = 4
default['httpd']['worker']['serverlimit'] = 16
default['httpd']['worker']['maxclients'] = 1024
default['httpd']['worker']['minsparethreads'] = 64
default['httpd']['worker']['maxsparethreads'] = 192
default['httpd']['worker']['threadsperchild'] = 64
default['httpd']['worker']['maxrequestsperchild'] = 0