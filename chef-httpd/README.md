# HTTPD cookbook

### Based on the Community Edition
This cookbook is based on the Opscode Apache2 cookbook, but is greatly simplified and slimmed down. The reason for this are:

* Ospcode implements a debian-style apache installation which is vastly different from el-style httpd.  
* The community cookbook is highly complex and designed to flex around virtual hosts and complex use cases.  
* This use case is just complicated enough that we need a small amount of flexibility.
* I wanted the Chef implementation of httpd to look enough like what people are used to that it won't be difficult to debug or verify functionality in problem-solving situations.  

### Virtual Hosts
This cookbook has no virtual hosts. However, in order to make one main cookbook and use it for any and all server profiles, there is a small amount of conf.d settings in other cookbooks using this one.

### Common vs Custom settings
This cookbook should include settings and configurations that are either parametrized or common to any implmentation. Any customizations or server-specific configurations should be implemented in those server cookbooks. you may refer to the example recipe/cookbook to see extensive use of overrides and customizations.

### Slimmed httpd.conf
The comments have been removed from the httpd.conf file in order to make it easy to see and read all the settings in the file. If you need assistance on how to configure settings, You can refer to the [Apache 2.2 Directives Quick Reference](http://httpd.apache.org/docs/2.2/mod/quickreference.html) for more information.

# Requirements
This cookbook carries a dependency on the community logrotate cookbook. This dep is carried over from the community apache2 cookbook and does not drive other dependencies in any way. If you have a different log management preference, the metadata.rb depends and the default.rb recipe can be edited to remove the use of logrotate.

# Usage
Include this recipe as a base "library" in your server cookbook to use it:

`include_recipe "httpd"`

# Attributes   
You can refer to the [Apache 2.2 Directives Quick Reference](http://httpd.apache.org/docs/2.2/mod/quickreference.html) for more information on these settings.  

* node['httpd']['package'] - yum package name (`httpd`)
* node['httpd']['dir'] - base config direction (`/etc/httpd`)
* node['httpd']['log_dir'] - where the logs go (`/var/log/httpd`)
* node['httpd']['log_dir'] = how much logging do you want? (`warn`)
* node['httpd']['error_log'] - name of the error log (`error.log`)
* node['httpd']['user'] - httpd process user name (`apache`)
* node['httpd']['group'] - httpd process group name (`apache`)
* node['httpd']['binary'] - what kind binary being used (`/usr/sbin/httpd.worker`)
* node['httpd']['icondir'] - httpd icon directory (`/var/www/icons`)
* node['httpd']['cache_dir'] - httpd cache directory (`/var/cache/httpd`)
* node['httpd']['pid_file'] - httpd pid location (`/var/run/httpd/httpd.pid`)
* node['httpd']['docroot'] - the default httpd document root (`/var/www/html`)
* node['httpd']['listen_ports'] - The default listen ports. This is an array ([`80`])
* node['httpd']['contact'] - the email for httpd to contact (`root@localhost`)
* node['httpd']['timeout'] - Value for the Timeout directive. (`300`)
* node['httpd']['keepalive'] - Value for the KeepAlive directive. (`On`)
* node['httpd']['keepaliverequests'] - Value for MaxKeepAliveRequests. (`100`)
* node['httpd']['keepalivetimeout'] - Value for the KeepAliveTimeout directive (`5`)
* node['httpd']['extendedstatus'] - Value for the ExtendedStatus directive (`Off`)
* node['httpd']['servertokens'] - Value for the ServerTokens directive (`Prod`)
* node['httpd']['serversignature'] - Value for the ServerSignature directive(`On`)

### WorkerMPM Values
Details on these settings can be found on the [MPM Common Directives Page](http://httpd.apache.org/docs/2.2/mod/mpm_common.html)

* node['httpd']['worker']['startservers'] - Initial number of server processes to start (`4`)
* node['httpd']['worker']['serverlimit'] - upper limit on configurable server processes (`16`)
* node['httpd']['worker']['maxclients'] -  Maximum number of simultaneous connections (`1024`)
* node['httpd']['worker']['minsparethreads'] - Minimum number of spare worker threads (`64`)
* node['httpd']['worker']['maxsparethreads'] - Maximum number of spare worker threads (`192`)
* node['httpd']['worker']['threadsperchild'] - Maximum number of spare worker threads (`64`)
* node['httpd']['worker']['maxrequestsperchild'] - Maximum number of requests a child process will handle (`0`)



# Recipes
### default 
The default recipe: 

* Installs the package
* Configures the service
* Creates the httpd.conf file from the template and node attributes
* Ensures the docroot is created with group apache
* Configures a default log_rotate scheme

# Author

Author:: Sascha Bates 